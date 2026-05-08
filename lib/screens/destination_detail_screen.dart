import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/premium_widgets.dart';
import 'ai_assist_screen.dart';
import 'audio_tour_screen.dart';
import 'food_screen.dart';
import 'game_screen.dart';
import 'hidden_gems_screen.dart';
import 'trip_scheduler_screen.dart';

class DestinationDetailScreen extends StatelessWidget {
  final String title;
  final String image;

  const DestinationDetailScreen({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final about =
        '$title is presented as an AI-assisted exploration zone, not as a bookable package. ExploreMate helps travelers understand the place, discover hidden gems around it, play city missions, plan their day, find nearby food, and start contextual audio guidance.';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: AppColors.primaryDeep,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton.filledTonal(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: title,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: AppColors.cardBg),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(.08),
                          AppColors.surface.withOpacity(.95),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SignalBadge(),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            _MetaPill(Icons.location_on_rounded, 'AI mapped place'),
                            _MetaPill(Icons.star_rounded, '4.8'),
                            _MetaPill(Icons.people_alt_rounded, 'Low crowd route'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore Options',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 640 ? 4 : 2,
                    childAspectRatio: MediaQuery.of(context).size.width > 360 ? .98 : .90,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _ActionCard(
                        title: 'Hidden Gems',
                        subtitle: 'Find secret nearby places',
                        icon: Icons.diamond_rounded,
                        color: AppColors.accent,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HiddenGemsScreen()),
                        ),
                      ),
                      _ActionCard(
                        title: 'City Explorer',
                        subtitle: 'Earn XP with place missions',
                        icon: Icons.stars_rounded,
                        color: AppColors.xpGold,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GameScreen()),
                        ),
                      ),
                      _ActionCard(
                        title: 'AI Guide',
                        subtitle: 'Ask about history, routes, timing',
                        icon: Icons.psychology_rounded,
                        color: const Color(0xFF8DB7FF),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AiAssistScreen()),
                        ),
                      ),
                      _ActionCard(
                        title: 'Audio Tour',
                        subtitle: 'Start contextual narration',
                        icon: Icons.graphic_eq_rounded,
                        color: AppColors.secondary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AudioTourScreen()),
                        ),
                      ),
                      _ActionCard(
                        title: 'Food Nearby',
                        subtitle: 'Mood-based restaurants',
                        icon: Icons.restaurant_rounded,
                        color: const Color(0xFFFFB067),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FoodScreen()),
                        ),
                      ),
                      _ActionCard(
                        title: 'Add To Plan',
                        subtitle: 'Place it in your itinerary',
                        icon: Icons.calendar_month_rounded,
                        color: const Color(0xFFC78BFF),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TripSchedulerScreen()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About This Place',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          about,
                          style: TextStyle(color: adaptiveMutedColor(context, .72), height: 1.55),
                        ),
                        const SizedBox(height: 18),
                        const Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _InfoChip('Best at sunset'),
                            _InfoChip('Photo friendly'),
                            _InfoChip('Hidden gems nearby'),
                            _InfoChip('XP missions ready'),
                            _InfoChip('Local food nearby'),
                            _InfoChip('Audio story ready'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AI Place Brief',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 12),
                        _BriefRow(Icons.wb_sunny_rounded, 'Weather fit', 'Clear evening window, good visibility.'),
                        _BriefRow(Icons.diamond_rounded, 'Hidden gem scan', 'AI can surface quieter nearby spots connected to this place.'),
                        _BriefRow(Icons.stars_rounded, 'City explorer missions', 'Complete photo, food, audio, and discovery quests for XP.'),
                        _BriefRow(Icons.route_rounded, 'Suggested route', 'Start with the scenic point, then food nearby.'),
                        _BriefRow(Icons.notifications_active_rounded, 'Live alert', 'AI can notify you if crowd level changes.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: adaptiveMutedColor(context, .62), fontSize: 11, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class _BriefRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _BriefRow(this.icon, this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: adaptiveMutedColor(context, .62), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalBadge extends StatelessWidget {
  const _SignalBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.accent.withOpacity(.5)),
      ),
      child: const Text(
        'AI exploration place',
        style: TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaPill(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.34),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.accent, size: 14),
          const SizedBox(width: 5),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 130),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      side: BorderSide(color: AppColors.accent.withOpacity(.25)),
      backgroundColor: AppColors.accent.withOpacity(.10),
    );
  }
}
