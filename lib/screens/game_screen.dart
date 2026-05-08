import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colors.dart';
import '../providers/app_state.dart';
import '../widgets/premium_widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final missions = [
      ('Visit 3 hidden gems', 2, 3, 200, Icons.diamond_rounded),
      ('Capture 5 landmarks', 1, 5, 350, Icons.photo_camera_rounded),
      ('Try 3 street foods', 3, 3, 150, Icons.ramen_dining_rounded),
      ('Complete an audio tour', 0, 1, 100, Icons.graphic_eq_rounded),
    ];
    final badges = [
      Icons.diamond_rounded,
      Icons.restaurant_rounded,
      Icons.explore_rounded,
      Icons.camera_alt_rounded,
      Icons.translate_rounded,
      Icons.nights_stay_rounded,
      Icons.hiking_rounded,
      Icons.auto_stories_rounded,
    ];

    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('City Explorer', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(
            'Missions, rewards, levels, and leaderboard momentum.',
            style: TextStyle(color: adaptiveMutedColor(context, .62)),
          ),
          const SizedBox(height: 18),
          XpProgressWidget(xp: state.xp, level: state.level),
          const SectionHeader(title: 'Active Missions'),
          ...missions.map((m) {
            final value = m.$2 / m.$3;
            final done = m.$2 == m.$3;
            return GlassCard(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(m.$5, color: done ? AppColors.success : AppColors.accent, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.$1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 7),
                        LinearProgressIndicator(
                          value: value,
                          minHeight: 7,
                          color: done ? AppColors.success : AppColors.accent,
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white12
                              : AppColors.textMuted.withOpacity(.18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      done ? 'Done' : '+${m.$4} XP',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: done ? AppColors.success : AppColors.xpGold, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SectionHeader(title: 'Achievement Badges'),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: badges.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (_, i) => GlassCard(
              padding: EdgeInsets.zero,
              child: Icon(
                badges[i],
                color: i < 4 ? AppColors.xpGold : adaptiveFaintColor(context),
                size: 32,
              ),
            ),
          ),
          const SectionHeader(title: 'Leaderboard'),
          ...['#1 Priya S. - 4820 XP', '#2 Ravi K. - 3910 XP', '#12 Arjun K. - 1240 XP'].map(
            (row) => GlassCard(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(Icons.leaderboard_rounded, color: AppColors.accent),
                  const SizedBox(width: 12),
                  Expanded(child: Text(row, style: const TextStyle(fontWeight: FontWeight.w800))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
