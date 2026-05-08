import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../services/translator_service.dart';
import '../models/translation_model.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  int _mode = 0; // 0 = Text, 1 = Camera
  String _sourceLang = 'English';
  String _targetLang = 'Telugu';
  final TextEditingController _inputCtrl = TextEditingController();
  String _translated = '';
  bool _isTranslating = false;

  final List<String> _languages = ['English', 'Hindi', 'Telugu', 'Tamil', 'Kannada', 'Malayalam', 'Bengali', 'Marathi', 'French', 'Spanish', 'Japanese'];

  final List<Map<String, String>> _history = [
    {'input': 'Where is the nearest bus stop?', 'output': 'సమీప బస్ స్టాప్ ఎక్కడ ఉంది?', 'from': 'EN', 'to': 'TE'},
    {'input': 'How much does this cost?', 'output': 'దీని ధర ఎంత?', 'from': 'EN', 'to': 'TE'},
    {'input': 'Can you help me?', 'output': 'మీరు నాకు సహాయం చేయగలరా?', 'from': 'EN', 'to': 'TE'},
  ];

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }

  void _translate() async {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() { _isTranslating = true; });
    try {
      final result = await TranslatorService.instance
          .translate(text, _sourceLang, _targetLang);
      if (!mounted) return;
      setState(() {
        _translated = result;
        _isTranslating = false;
      });
      // Save to history
      await TranslatorService.instance.saveToHistory(
        TranslationModel(
          id: 'tr-${DateTime.now().millisecondsSinceEpoch}',
          userId: 'mock-uid-001',
          sourceText: text,
          translatedText: result,
          fromLang: _sourceLang,
          toLang: _targetLang,
          savedAt: DateTime.now(),
        ),
      );
    } catch (_) {
      if (mounted) setState(() => _isTranslating = false);
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLang;
      _sourceLang = _targetLang;
      _targetLang = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Translator'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildModeToggle(),
          if (_mode == 0) ...[
            _buildLangRow(),
            _buildTextInput(),
            _buildTranslationOutput(),
            _buildQuickPhrases(),
          ] else
            _buildCameraMode(),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: _modeTab('Text', Icons.text_fields_rounded, 0)),
          const SizedBox(width: 8),
          Expanded(child: _modeTab('Camera', Icons.camera_alt_rounded, 1)),
        ],
      ),
    );
  }

  Widget _modeTab(String label, IconData icon, int index) {
    final isSelected = _mode == index;
    return GestureDetector(
      onTap: () => setState(() => _mode = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderColor,
              width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : AppColors.textMuted),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _buildLangRow() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Row(
        children: [
          Expanded(child: _langDropdown(_sourceLang, (v) => setState(() => _sourceLang = v!))),
          GestureDetector(
            onTap: _swapLanguages,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.tileLight1,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.swap_horiz_rounded, color: AppColors.primary, size: 18),
            ),
          ),
          Expanded(child: _langDropdown(_targetLang, (v) => setState(() => _targetLang = v!))),
        ],
      ),
    );
  }

  Widget _langDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.tileLight1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: _languages.map((l) => DropdownMenuItem(value: l, child: Text(l, style: const TextStyle(fontSize: 12)))).toList(),
          onChanged: onChanged,
          style: const TextStyle(color: AppColors.primaryDark, fontSize: 12),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildTextInput() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor, width: 0.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _inputCtrl,
              maxLines: 3,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
              decoration: const InputDecoration(
                hintText: 'Type text to translate…',
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.tileLight1, width: 0.5)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.mic_rounded, color: AppColors.textMuted, size: 20), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                  const SizedBox(width: 12),
                  IconButton(onPressed: () => _inputCtrl.clear(), icon: const Icon(Icons.clear_rounded, color: AppColors.textMuted, size: 18), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                ]),
                ElevatedButton(
                  onPressed: _translate,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: const Text('Translate', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationOutput() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.tileLight1,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_targetLang,
              style: const TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          _isTranslating
              ? const SizedBox(height: 20, child: LinearProgressIndicator(
                  backgroundColor: AppColors.borderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)))
              : Text(
                  _translated.isNotEmpty ? _translated : 'Translation will appear here…',
                  style: TextStyle(
                      fontSize: 14,
                      color: _translated.isNotEmpty ? AppColors.primaryDark : AppColors.textMuted,
                      fontWeight: _translated.isNotEmpty ? FontWeight.w500 : FontWeight.normal)),
          if (_translated.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(children: [
              _iconBtn(Icons.volume_up_rounded),
              const SizedBox(width: 8),
              _iconBtn(Icons.copy_rounded),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, color: AppColors.primary, size: 14),
    );
  }

  Widget _buildQuickPhrases() {
    final phrases = ['Hello', 'Thank you', 'Help me', 'How much?', 'Where is?'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(14, 0, 14, 6),
          child: Text('QUICK PHRASES',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600,
                  color: AppColors.primary, letterSpacing: 0.8)),
        ),
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: phrases.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ActionChip(
                label: Text(phrases[i], style: const TextStyle(fontSize: 11, color: AppColors.primaryDark)),
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.borderColor, width: 0.5),
                onPressed: () { _inputCtrl.text = phrases[i]; _translate(); },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCameraMode() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 260,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.camera_rounded, color: Colors.white24, size: 80),
                Positioned(
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text('Point at text to translate', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text('Camera translate works by detecting\ntext in signs, menus and documents.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.6)),
        ],
      ),
    );
  }
}
