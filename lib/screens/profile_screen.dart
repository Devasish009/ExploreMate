import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colors.dart';
import '../models/demo_data.dart';
import '../providers/app_state.dart';
import '../widgets/premium_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final dark = state.themeMode == ThemeMode.dark;
    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 78,
                      height: 78,
                      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.cyanGradient),
                      child: const Center(
                        child: Text('AK', style: TextStyle(color: AppColors.primaryDeep, fontSize: 24, fontWeight: FontWeight.w900)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Arjun Kumar', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 4),
                          Text(
                            'Pro Explorer - Vizag',
                            style: TextStyle(color: adaptiveMutedColor(context, .62)),
                          ),
                        ],
                      ),
                    ),
                    Switch(value: dark, onChanged: state.toggleTheme),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _Stat('Trips', '12'),
                    _Stat('Places', '48'),
                    _Stat('Badges', '8'),
                  ],
                ),
              ],
            ),
          ),
          XpProgressWidget(xp: state.xp, level: state.level),
          const SectionHeader(title: 'Travel History'),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: destinations
                  .map((d) => Container(
                        width: 220,
                        margin: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(d['image'] as String, fit: BoxFit.cover),
                              Container(color: Colors.black.withOpacity(.32)),
                              Positioned(
                                left: 14,
                                bottom: 14,
                                right: 14,
                                child: Text(d['name'] as String, style: const TextStyle(fontWeight: FontWeight.w900)),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SectionHeader(title: 'Saved Places & Settings'),
          _Tile(Icons.favorite_rounded, 'Saved places', '18 places synced'),
          _Tile(Icons.workspace_premium_rounded, 'Achievements', 'Gem Hunter, Foodie, Navigator'),
          _Tile(Icons.security_rounded, 'Privacy and offline maps', 'Manage local travel data'),
          _Tile(Icons.tune_rounded, 'AI preferences', 'Adventure, food-first, low crowds'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.accent)),
          Text(label, style: TextStyle(color: adaptiveMutedColor(context, .56), fontSize: 12)),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Tile(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                Text(subtitle, style: TextStyle(color: adaptiveMutedColor(context, .56), fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: adaptiveFaintColor(context)),
        ],
      ),
    );
  }
}
