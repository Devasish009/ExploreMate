import 'package:flutter/material.dart';
import '../app_colors.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int _selectedMood = 0;
  final List<Map<String, String>> _moods = [
    {'label': 'Adventurous', 'icon': '🔥'},
    {'label': 'Comfort', 'icon': '😌'},
    {'label': 'Energetic', 'icon': '⚡'},
    {'label': 'Calm', 'icon': '🧘'},
  ];

  final List<Map<String, dynamic>> _foods = [
    {'name': 'Spicy Chole Bhature', 'type': 'Punjabi', 'rating': '4.7', 'dist': '1.2 km', 'tag': 'Hot', 'icon': Icons.rice_bowl_rounded},
    {'name': 'Szechuan Noodles', 'type': 'Chinese', 'rating': '4.5', 'dist': '2.8 km', 'tag': 'Spicy', 'icon': Icons.ramen_dining_rounded},
    {'name': 'Peri Peri Bowl', 'type': 'Fusion', 'rating': '4.3', 'dist': '0.8 km', 'tag': 'New', 'icon': Icons.set_meal_rounded},
    {'name': 'Street Tacos', 'type': 'Mexican', 'rating': '4.6', 'dist': '3.4 km', 'tag': 'Bold', 'icon': Icons.local_dining_rounded},
    {'name': 'Masala Dosa', 'type': 'South Indian', 'rating': '4.8', 'dist': '0.5 km', 'tag': 'Classic', 'icon': Icons.breakfast_dining_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          _buildHeader(),
          _buildMoodRow(),
          _buildWeatherBadge(),
          Expanded(child: _buildFoodList()),
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
      child: const Row(
        children: [
          Icon(Icons.restaurant_rounded, color: Colors.white, size: 22),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Food Explorer',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              Text('How are you feeling today?',
                  style: TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodRow() {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: _moods.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => _selectedMood = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: i == _selectedMood ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: i == _selectedMood ? AppColors.primary : AppColors.borderColor,
                  width: 0.5,
                ),
              ),
              child: Text(
                '${_moods[i]['icon']} ${_moods[i]['label']}',
                style: TextStyle(
                  fontSize: 11,
                  color: i == _selectedMood ? Colors.white : AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherBadge() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
      child: Row(
        children: [
          Container(
            width: 7, height: 7,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          const Text('Sunny · 32°C · Bold flavours matched',
              style: TextStyle(fontSize: 10, color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildFoodList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
          child: Text('RECOMMENDED FOR YOU',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600,
                  color: AppColors.primary, letterSpacing: 0.8)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _foods.length,
            itemBuilder: (_, i) {
              final f = _foods[i];
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
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.tileLight2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(f['icon'] as IconData, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f['name'] as String,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
                          const SizedBox(height: 2),
                          Text('${f['type']} · ★ ${f['rating']} · ${f['dist']}',
                              style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: AppColors.tileLight1,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(f['tag'] as String,
                          style: const TextStyle(fontSize: 9, color: AppColors.primaryDark, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
