import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/premium_widgets.dart';

class SmartTravelToolsScreen extends StatelessWidget {
  const SmartTravelToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      _Tool(
        'AI Trip Memory',
        'Learns food, budget, pace, language, and crowd preferences.',
        Icons.memory_rounded,
        AppColors.accent,
        ['Food-first traveler', 'Low crowd routes', 'Mid-range budget', 'Hindi + English'],
      ),
      _Tool(
        'Offline Travel Mode',
        'Download plans, map previews, phrases, contacts, and audio tours.',
        Icons.download_for_offline_rounded,
        const Color(0xFF8DB7FF),
        ['Itinerary cached', 'Translator phrases', 'Emergency contacts', 'Audio tours'],
      ),
      _Tool(
        'AI Safety Companion',
        'Area safety score, risk alerts, route sharing, and emergency info.',
        Icons.health_and_safety_rounded,
        AppColors.success,
        ['Safe route score 92%', 'Weather risk low', 'Live route sharing', 'SOS ready'],
      ),
      _Tool(
        'Smart Day Optimizer',
        'Reorders your day using weather, distance, opening hours, and crowds.',
        Icons.auto_awesome_rounded,
        AppColors.secondary,
        ['Move beach to sunset', 'Lunch near heritage walk', 'Avoid 4 PM crowd', 'Save 42 min'],
      ),
      _Tool(
        'AR Place Scanner',
        'Camera-first landmark, sign, and menu recognition interface.',
        Icons.view_in_ar_rounded,
        const Color(0xFFC78BFF),
        ['Landmark facts', 'Menu translation', 'Sign detection', 'Instant AI overlay'],
      ),
      _Tool(
        'Local Culture Cards',
        'Etiquette, phrases, festivals, dress codes, and food customs.',
        Icons.diversity_3_rounded,
        AppColors.xpGold,
        ['Greeting tips', 'Temple etiquette', 'Local phrases', 'Festival notes'],
      ),
      _Tool(
        'Expense Splitter',
        'Track group expenses, split bills, and estimate trip budget.',
        Icons.payments_rounded,
        const Color(0xFF57C7FF),
        ['INR 12,400 total', '4 travelers', 'Food split', 'Activity split'],
      ),
      _Tool(
        'AI Photo Journal',
        'Auto-build a trip timeline with captions, badges, and story cards.',
        Icons.auto_stories_rounded,
        const Color(0xFFFF8FB3),
        ['8 moments captured', 'AI captions', 'Shareable story', 'XP badges'],
      ),
      _Tool(
        'Emergency Quick Panel',
        'SOS, trusted contact, hotel address, and live location sharing.',
        Icons.sos_rounded,
        AppColors.danger,
        ['Police 100', 'Ambulance 108', 'Trusted contact', 'Share location'],
      ),
      _Tool(
        'ExploreMate Pro Dashboard',
        'Travel personality, streaks, badges, states explored, and insights.',
        Icons.workspace_premium_rounded,
        AppColors.accentLight,
        ['Trailblazer profile', '12 trips', '8 badges', '4-day streak'],
      ),
    ];

    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton.filledTonal(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Smart Travel Tools',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'A premium AI toolkit for safer, smarter, more personal exploration.',
            style: TextStyle(color: adaptiveMutedColor(context, .64), height: 1.4),
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.cyanGradient),
                  child: const Icon(Icons.psychology_alt_rounded, color: AppColors.primaryDeep),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ExploreMate Intelligence Layer', style: TextStyle(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(
                        'These modules are frontend-ready placeholders for real AI, maps, safety, camera, and payment APIs.',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: adaptiveMutedColor(context, .62), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'All Premium Features'),
          ...tools.map((tool) => _ToolPanel(tool: tool)),
        ],
      ),
    );
  }
}

class _Tool {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> chips;

  const _Tool(this.title, this.subtitle, this.icon, this.color, this.chips);
}

class _ToolPanel extends StatelessWidget {
  final _Tool tool;

  const _ToolPanel({required this.tool});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tool.color.withOpacity(.18),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(tool.icon, color: tool.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: adaptiveMutedColor(context, .62), fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tool.chips
                .map(
                  (chip) => Chip(
                    label: Text(chip, overflow: TextOverflow.ellipsis),
                    avatar: Icon(Icons.check_circle_rounded, color: tool.color, size: 16),
                    backgroundColor: tool.color.withOpacity(.10),
                    side: BorderSide(color: tool.color.withOpacity(.22)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          _ToolPreview(tool: tool),
        ],
      ),
    );
  }
}

class _ToolPreview extends StatelessWidget {
  final _Tool tool;

  const _ToolPreview({required this.tool});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: tool.color.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tool.color.withOpacity(.20)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_graph_rounded, color: tool.color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _previewText(tool.title),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: adaptiveMutedColor(context, .72), fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  String _previewText(String title) {
    switch (title) {
      case 'Smart Day Optimizer':
        return 'AI plan updated: heritage walk first, food stop next, beach at golden hour.';
      case 'Emergency Quick Panel':
        return 'One-tap SOS panel with live location and trusted contact shortcut.';
      case 'Expense Splitter':
        return 'Group split estimate ready: stay, food, transport, activities.';
      case 'AI Photo Journal':
        return 'Generate a cinematic story card after each completed mission.';
      case 'AR Place Scanner':
        return 'Camera overlay detects signs, landmarks, and menu items.';
      default:
        return 'Ready to connect with live AI services and travel APIs.';
    }
  }
}
