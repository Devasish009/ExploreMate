import 'package:flutter/material.dart';
import '../app_colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _missions = [
    {'name': 'Visit 3 hidden gems', 'done': 2, 'total': 3, 'xp': 200, 'icon': Icons.diamond_rounded, 'color': AppColors.tileLight1},
    {'name': 'Capture 5 landmarks', 'done': 1, 'total': 5, 'xp': 350, 'icon': Icons.photo_camera_rounded, 'color': AppColors.tileLight2},
    {'name': 'Try 3 street foods', 'done': 3, 'total': 3, 'xp': 150, 'icon': Icons.ramen_dining_rounded, 'color': AppColors.tileLight3},
    {'name': 'Complete an audio tour', 'done': 0, 'total': 1, 'xp': 100, 'icon': Icons.audiotrack_rounded, 'color': AppColors.tileLight1},
    {'name': 'Use translator 5 times', 'done': 2, 'total': 5, 'xp': 80, 'icon': Icons.translate_rounded, 'color': AppColors.tileLight2},
  ];

  final List<Map<String, dynamic>> _badges = [
    {'name': 'Gem Hunter', 'icon': Icons.diamond_rounded, 'earned': true},
    {'name': 'Foodie', 'icon': Icons.restaurant_rounded, 'earned': true},
    {'name': 'Navigator', 'icon': Icons.explore_rounded, 'earned': true},
    {'name': 'Shutterbug', 'icon': Icons.camera_alt_rounded, 'earned': true},
    {'name': 'Linguist', 'icon': Icons.translate_rounded, 'earned': false},
    {'name': 'Night Owl', 'icon': Icons.nights_stay_rounded, 'earned': false},
    {'name': 'Trailblazer', 'icon': Icons.hiking_rounded, 'earned': false},
    {'name': 'Storyteller', 'icon': Icons.auto_stories_rounded, 'earned': false},
  ];

  final List<Map<String, dynamic>> _leaderboard = [
    {'rank': 1, 'name': 'Priya S.', 'xp': 4820, 'level': 9},
    {'rank': 2, 'name': 'Ravi K.', 'xp': 3910, 'level': 8},
    {'rank': 3, 'name': 'Anjali M.', 'xp': 2740, 'level': 7},
    {'rank': 12, 'name': 'Arjun K. (You)', 'xp': 1240, 'level': 4, 'isMe': true},
    {'rank': 13, 'name': 'Deepa R.', 'xp': 1180, 'level': 4},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          _buildHeader(),
          _buildStatsRow(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildMissions(), _buildBadges(), _buildLeaderboard()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16, right: 16, bottom: 10,
      ),
      child: Row(
        children: [
          const Icon(Icons.stars_rounded, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('City Explorer',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('#12 Global',
                style: TextStyle(color: AppColors.accent, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'label': 'Total XP', 'value': '1,240', 'color': AppColors.accent},
      {'label': 'Level', 'value': 'Lv.4', 'color': Colors.white},
      {'label': 'Badges', 'value': '8', 'color': AppColors.accent},
    ];
    return Container(
      color: AppColors.primaryDark,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
      child: Row(
        children: stats.map((s) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(s['value'] as String,
                    style: TextStyle(color: s['color'] as Color, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(s['label'] as String,
                    style: const TextStyle(color: Colors.white38, fontSize: 9)),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textMuted,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        tabs: const [Tab(text: 'Missions'), Tab(text: 'Badges'), Tab(text: 'Leaderboard')],
      ),
    );
  }

  Widget _buildMissions() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _missions.length,
      itemBuilder: (_, i) {
        final m = _missions[i];
        final progress = (m['done'] as int) / (m['total'] as int);
        final isDone = m['done'] == m['total'];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                    color: m['color'] as Color,
                    borderRadius: BorderRadius.circular(9)),
                child: Icon(m['icon'] as IconData, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['name'] as String,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textDark)),
                    const SizedBox(height: 2),
                    Text(isDone ? 'Completed!' : '${m['done']} of ${m['total']} done',
                        style: TextStyle(fontSize: 9,
                            color: isDone ? AppColors.success : AppColors.primary)),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.tileLight1,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            isDone ? AppColors.success : AppColors.primary),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(isDone ? 'Done!' : '+${m['xp']} XP',
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w500,
                      color: isDone ? AppColors.success : AppColors.primary)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadges() {
    return GridView.builder(
      padding: const EdgeInsets.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12,
      ),
      itemCount: _badges.length,
      itemBuilder: (_, i) {
        final b = _badges[i];
        final earned = b['earned'] as bool;
        return Column(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: earned ? AppColors.tileLight1 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: earned ? AppColors.borderColor : Colors.grey.shade200,
                    width: 0.5),
              ),
              child: Icon(b['icon'] as IconData,
                  color: earned ? AppColors.primary : Colors.grey.shade400,
                  size: 24),
            ),
            const SizedBox(height: 4),
            Text(b['name'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 8,
                    color: earned ? AppColors.primary : Colors.grey,
                    fontWeight: earned ? FontWeight.w500 : FontWeight.normal),
                maxLines: 2),
          ],
        );
      },
    );
  }

  Widget _buildLeaderboard() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _leaderboard.length,
      itemBuilder: (_, i) {
        final l = _leaderboard[i];
        final isMe = l['isMe'] == true;
        final rank = l['rank'] as int;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? AppColors.tileLight1 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isMe ? AppColors.primary : AppColors.borderColor,
                width: isMe ? 1 : 0.5),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Text('#$rank',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700,
                        color: rank <= 3 ? AppColors.primaryDark : AppColors.textMuted)),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.accent,
                child: Text(
                    (l['name'] as String).substring(0, 1),
                    style: TextStyle(color: AppColors.primaryDeep, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l['name'] as String,
                        style: TextStyle(
                            fontSize: 12, fontWeight: isMe ? FontWeight.w600 : FontWeight.w500,
                            color: AppColors.textDark)),
                    Text('Level ${l['level']}',
                        style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                  ],
                ),
              ),
              Text('${l['xp']} XP',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
            ],
          ),
        );
      },
    );
  }
}
