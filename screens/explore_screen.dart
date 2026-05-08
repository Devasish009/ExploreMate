import 'package:flutter/material.dart';
import '../app_colors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedChip = 0;
  final List<String> _chips = ['All', 'Gems', 'Food', 'Tours'];

  final List<Map<String, dynamic>> _places = [
    {'name': 'Lotus Lake Viewpoint', 'type': 'Hidden gem', 'dist': '2.3 km', 'tag': 'Gem', 'icon': Icons.water_rounded},
    {'name': 'Old Quarter Market', 'type': 'Cultural', 'dist': '3.7 km', 'tag': 'Popular', 'icon': Icons.store_rounded},
    {'name': 'Sunset Cliffside', 'type': 'Scenic', 'dist': '6.1 km', 'tag': 'Must-see', 'icon': Icons.landscape_rounded},
    {'name': 'Borra Caves', 'type': 'Nature', 'dist': '92 km', 'tag': 'Gem', 'icon': Icons.terrain_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          _buildHeader(),
          _buildMapPlaceholder(),
          _buildChips(),
          Expanded(child: _buildPlacesList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16, right: 16, bottom: 12,
      ),
      child: Row(
        children: [
          const Icon(Icons.explore_rounded, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('Explore Nearby',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('3 places', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 180,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.tileLight2, AppColors.tileLight1],
        ),
      ),
      child: Stack(
        children: [
          GridPaper(
            color: AppColors.primary.withOpacity(0.06),
            divisions: 2,
            subdivisions: 1,
            interval: 60,
            child: const SizedBox.expand(),
          ),
          _buildRoad(horizontal: true, top: 0.44),
          _buildRoad(horizontal: false, left: 0.58),
          _buildMapDot(top: 0.28, left: 0.27, color: AppColors.primary),
          _buildMapDot(top: 0.55, left: 0.56, color: const Color(0xFFE08B3A)),
          _buildMapDot(top: 0.18, left: 0.62, color: AppColors.accent),
          _buildCurrentLocation(top: 0.40, left: 0.55),
          Positioned(
            top: 10, right: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 8,
                    ),
                  ]),
              child: const Icon(Icons.my_location_rounded,
                  color: AppColors.primary, size: 18),
            ),
          ),
          // Map label overlay
          Positioned(
            bottom: 8, left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryDeep.withOpacity(0.85),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('Map View',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoad({required bool horizontal, double? top, double? left}) {
    return Positioned.fill(
      child: LayoutBuilder(builder: (ctx, constraints) {
        if (horizontal) {
          return Positioned(
            top: constraints.maxHeight * (top ?? 0.5) - 2.5,
            left: 0, right: 0,
            child: Container(height: 5, color: Colors.white.withOpacity(0.7)),
          );
        }
        return Positioned(
          left: constraints.maxWidth * (left ?? 0.5) - 2.5,
          top: 0, bottom: 0,
          child: Container(width: 5, color: Colors.white.withOpacity(0.7)),
        );
      }),
    );
  }

  Widget _buildMapDot({required double top, required double left, required Color color}) {
    return Positioned.fill(
      child: LayoutBuilder(builder: (ctx, constraints) => Positioned(
        top: constraints.maxHeight * top - 6,
        left: constraints.maxWidth * left - 6,
        child: Container(
          width: 12, height: 12,
          decoration: BoxDecoration(
            color: color, shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
      )),
    );
  }

  Widget _buildCurrentLocation({required double top, required double left}) {
    return Positioned.fill(
      child: LayoutBuilder(builder: (ctx, constraints) => Stack(children: [
        Positioned(
          top: constraints.maxHeight * top - 12,
          left: constraints.maxWidth * left - 12,
          child: Container(
            width: 24, height: 24,
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: constraints.maxHeight * top - 8,
          left: constraints.maxWidth * left - 8,
          child: Container(
            width: 16, height: 16,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
          ),
        ),
      ])),
    );
  }

  Widget _buildChips() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _chips.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 6),
          child: ChoiceChip(
            label: Text(_chips[i], style: const TextStyle(fontSize: 11)),
            selected: i == _selectedChip,
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(color: i == _selectedChip ? Colors.white : AppColors.textMid),
            backgroundColor: Colors.white,
            side: const BorderSide(color: AppColors.borderColor, width: 0.5),
            onSelected: (_) => setState(() => _selectedChip = i),
          ),
        ),
      ),
    );
  }

  Widget _buildPlacesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _places.length,
      itemBuilder: (_, i) {
        final p = _places[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: AppColors.tileLight1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(p['icon'] as IconData, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['name'] as String,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
                    const SizedBox(height: 2),
                    Text('${p['type']} · ${p['dist']}',
                        style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.tileLight1,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(p['tag'] as String,
                    style: const TextStyle(fontSize: 9, color: AppColors.primaryDark, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }
}
