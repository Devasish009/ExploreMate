import 'package:flutter/material.dart';
import '../app_colors.dart';

class AiAssistScreen extends StatefulWidget {
  const AiAssistScreen({super.key});

  @override
  State<AiAssistScreen> createState() => _AiAssistScreenState();
}

class _AiAssistScreenState extends State<AiAssistScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'role': 'ai',
      'text': 'Hello! I\'m your AI travel guide. Where would you like to explore today? I can help with hidden gems, food recommendations, directions, and much more!',
    },
    {
      'role': 'user',
      'text': 'Best hidden gems in Vizag?',
    },
    {
      'role': 'ai',
      'text': 'Here are 3 amazing hidden gems near you:\n\n1. 🏔 Borra Caves – Ancient limestone formations, 92 km away\n2. 🌊 Yarada Beach – Secluded beach enclosed by hills, 15 km\n3. 🏛 Bheemunipatnam – Dutch ruins & calm waters, 24 km\n\nWant audio tours for any of these?',
    },
  ];

  final List<String> _suggestions = [
    'Start audio tour',
    'Get directions',
    'Add to schedule',
    'Food nearby',
    'Weather today',
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _ctrl.clear();
      _isTyping = true;
    });
    _scrollToBottom();
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _messages.add({
        'role': 'ai',
        'text': 'Great question! Based on your interest in "$text", I\'d recommend exploring the hidden gems around Vizag. Would you like me to create an itinerary or start an audio tour?',
      });
      _isTyping = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('AI Assist'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 4),
              const Text('Online', style: TextStyle(color: Colors.white70, fontSize: 11)),
              const SizedBox(width: 14),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          if (_isTyping) _buildTypingIndicator(),
          _buildSuggestions(),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollCtrl,
      padding: const EdgeInsets.all(14),
      itemCount: _messages.length,
      itemBuilder: (_, i) {
        final m = _messages[i];
        final isAi = m['role'] == 'ai';
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isAi) ...[
                Container(
                  width: 28, height: 28,
                  margin: const EdgeInsets.only(right: 8, bottom: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 16),
                ),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  decoration: BoxDecoration(
                    color: isAi ? Colors.white : AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(isAi ? 4 : 14),
                      bottomRight: Radius.circular(isAi ? 14 : 4),
                    ),
                    border: isAi ? Border.all(color: AppColors.borderColor, width: 0.5) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m['text'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: isAi ? AppColors.textDark : Colors.white,
                              height: 1.5)),
                      if (isAi) ...[
                        const SizedBox(height: 4),
                        const Text('ExploreMate AI',
                            style: TextStyle(fontSize: 9, color: AppColors.primary)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderColor, width: 0.5),
            ),
            child: Row(
              children: [
                _dot(0), _dot(100), _dot(200),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(int delayMs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 600 + delayMs),
        builder: (_, v, __) => Container(
          width: 6, height: 6,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.4 + 0.6 * v),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _suggestions.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 6, bottom: 4),
          child: ActionChip(
            label: Text(_suggestions[i], style: const TextStyle(fontSize: 11, color: AppColors.primaryDark)),
            backgroundColor: AppColors.tileLight1,
            side: BorderSide.none,
            onPressed: () => _sendMessage(_suggestions[i]),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderColor, width: 0.5),
              ),
              child: TextField(
                controller: _ctrl,
                style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                decoration: const InputDecoration(
                  hintText: 'Ask anything about your trip…',
                  hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _sendMessage(_ctrl.text),
            child: Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
