import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/app_drawer.dart';
import 'explore_screen.dart';
import 'food_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = const [
    _HomeTab(),
    ExploreScreen(),
    FoodScreen(),
    GameScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Explore'),
    BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded), label: 'Food'),
    BottomNavigationBarItem(icon: Icon(Icons.stars_rounded), label: 'Game'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: _navItems,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        backgroundColor: AppColors.primary,
        mini: true,
        child: const Icon(Icons.menu_rounded, color: Colors.white),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(child: _buildChips()),
          SliverToBoxAdapter(child: _buildSectionLabel('Hidden Gems')),
          SliverToBoxAdapter(child: _buildGemCards()),
          SliverToBoxAdapter(child: _buildSectionLabel('Your Progress')),
          SliverToBoxAdapter(child: _buildXPCard()),
          SliverToBoxAdapter(child: _buildSectionLabel('AI Audio Tour')),
          SliverToBoxAdapter(child: _buildAudioCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 150,
      backgroundColor: AppColors.primaryDeep,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.accent,
            child: Text('AK',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDeep)),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryDeep,
                AppColors.primaryDark,
                Color(0xFF3A9A98),
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 90, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Good morning 👋',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text('Explore the ocean of possibilities',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.62), fontSize: 12.5)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.18), width: 0.8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded,
                        color: Colors.white.withOpacity(0.55), size: 17),
                    const SizedBox(width: 8),
                    Text('Search places, gems, food…',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 12.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChips() {
    final chips = ['All', 'Nearby', 'Trending', 'Saved'];
    return SizedBox(
      height: 46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        itemCount: chips.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 7),
          child: ChoiceChip(
            label: Text(chips[i], style: const TextStyle(fontSize: 11)),
            selected: i == 0,
            selectedColor: AppColors.primary,
            labelStyle:
                TextStyle(color: i == 0 ? Colors.white : AppColors.textMid),
            backgroundColor: Colors.white,
            side: const BorderSide(color: AppColors.borderColor, width: 0.5),
            onSelected: (_) {},
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 13,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 7),
          Text(label.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                  letterSpacing: 1.0)),
        ],
      ),
    );
  }

  Widget _buildGemCards() {
    final gems = [
      {'name': 'Lotus Lake', 'dist': '2.3 km', 'color': AppColors.gemOcean1, 'icon': Icons.water_rounded},
      {'name': 'Night Bazaar', 'dist': '4.1 km', 'color': AppColors.gemOcean2, 'icon': Icons.store_rounded},
      {'name': 'Cliff Cafe', 'dist': '7.8 km', 'color': AppColors.gemOcean3, 'icon': Icons.landscape_rounded},
    ];
    return SizedBox(
      height: 148,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: gems.length,
        itemBuilder: (_, i) {
          final gem = gems[i];
          return Container(
            width: 126,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderColor, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 76,
                  decoration: BoxDecoration(
                    color: gem['color'] as Color,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        right: -10,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.06),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(gem['icon'] as IconData,
                            color: Colors.white.withOpacity(0.5), size: 32),
                      ),
                      Positioned(
                        bottom: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Gem',
                              style: TextStyle(color: Colors.white, fontSize: 8.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(gem['name'] as String,
                          style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.near_me_rounded,
                              size: 9, color: AppColors.primary),
                          const SizedBox(width: 3),
                          Text(gem['dist'] as String,
                              style: const TextStyle(
                                  fontSize: 9.5, color: AppColors.primary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildXPCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDeep, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDeep.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('City Explorer · Lv.4',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('1,240 XP',
                    style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: 0.62,
              backgroundColor: Colors.white.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('62% to Lv.5',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 9.5)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: ['Gem Hunter', 'Foodie', 'Navigator'].map((b) => Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.15), width: 0.5),
                ),
                child: Text(b,
                    style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 9.5)),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.audiotrack_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gateway of India',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  SizedBox(height: 2),
                  Text('12 min · English',
                      style: TextStyle(fontSize: 10.5, color: AppColors.primary)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.tileLight1,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('4.8 ★',
                    style: TextStyle(fontSize: 10, color: AppColors.primaryDark)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.35,
              backgroundColor: AppColors.tileLight1,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 3.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('4:12',
                  style: TextStyle(
                      fontSize: 9.5, color: Colors.grey.shade400)),
              Text('12:00',
                  style: TextStyle(
                      fontSize: 9.5, color: Colors.grey.shade400)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlBtn(Icons.skip_previous_rounded, false),
              const SizedBox(width: 14),
              _controlBtn(Icons.play_arrow_rounded, true),
              const SizedBox(width: 14),
              _controlBtn(Icons.skip_next_rounded, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _controlBtn(IconData icon, bool isPrimary) {
    return Container(
      width: isPrimary ? 42 : 32,
      height: isPrimary ? 42 : 32,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              )
            : null,
        color: isPrimary ? null : AppColors.tileLight1,
        shape: BoxShape.circle,
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Icon(icon,
          color: isPrimary ? Colors.white : AppColors.primary,
          size: isPrimary ? 22 : 18),
    );
  }
}
