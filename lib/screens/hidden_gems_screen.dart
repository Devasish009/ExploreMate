import 'package:flutter/material.dart';
import '../app_colors.dart';

class HiddenGemsScreen extends StatefulWidget {
  const HiddenGemsScreen({super.key});

  @override
  State<HiddenGemsScreen> createState() => _HiddenGemsScreenState();
}

class _HiddenGemsScreenState extends State<HiddenGemsScreen> {
  int _selectedChip = 0;
  final List<String> _chips = ['All', 'Nature', 'Culture', 'Food', 'Adventure'];

  final List<Map<String, dynamic>> _gems = [
    {'name': 'Borra Caves', 'type': 'Nature', 'dist': '92 km', 'rating': '4.8', 'tag': 'Gem', 'color': AppColors.gemGreen1, 'desc': 'Ancient limestone caves with stunning stalactite formations.'},
    {'name': 'Bheemunipatnam', 'type': 'Beach', 'dist': '24 km', 'rating': '4.6', 'tag': 'Gem', 'color': AppColors.gemGreen2, 'desc': 'Less crowded beach with Dutch-era ruins and calm waters.'},
    {'name': 'Simhachalam Temple', 'type': 'Heritage', 'dist': '16 km', 'rating': '4.7', 'tag': 'Local', 'color': AppColors.gemGreen3, 'desc': 'Ancient Vishnu temple atop the Simhachalam hill.'},
    {'name': 'Yarada Beach', 'type': 'Beach', 'dist': '15 km', 'rating': '4.5', 'tag': 'Gem', 'color': AppColors.primaryDark, 'desc': 'Secluded beach enclosed by hills, accessible by a scenic route.'},
    {'name': 'Araku Valley', 'type': 'Nature', 'dist': '115 km', 'rating': '4.9', 'tag': 'Must-see', 'color': AppColors.primaryDeep, 'desc': 'Scenic hill station with coffee plantations and tribal culture.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Hidden Gem Finder'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.5), size: 16),
                  const SizedBox(width: 8),
                  Text('Search hidden gems…',
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildChips(),
          Expanded(child: _buildGemList()),
        ],
      ),
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

  Widget _buildGemList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      itemCount: _gems.length,
      itemBuilder: (_, i) {
        final g = _gems[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
          ),
          child: Column(
            children: [
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: g['color'] as Color,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 8, left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.black38, borderRadius: BorderRadius.circular(6)),
                        child: Text(g['tag'] as String,
                            style: const TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.black38, borderRadius: BorderRadius.circular(6)),
                        child: Text('★ ${g['rating']}',
                            style: const TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(g['name'] as String,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        Text(g['dist'] as String,
                            style: const TextStyle(fontSize: 11, color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(g['type'] as String,
                        style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                    const SizedBox(height: 6),
                    Text(g['desc'] as String,
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.4)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.map_rounded, size: 14),
                            label: const Text('Directions', style: TextStyle(fontSize: 11)),
                            style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary, width: 0.5),
                                padding: const EdgeInsets.symmetric(vertical: 6)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.audiotrack_rounded, size: 14),
                            label: const Text('Audio Tour', style: TextStyle(fontSize: 11)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
