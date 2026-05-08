import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/demo_data.dart';
import '../widgets/premium_widgets.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int mood = 0;

  final foods = const [
    ('Monsoon Ramen Bar', 'Hot bowls - 1.2 km - 4.8', Icons.ramen_dining_rounded),
    ('Sunset Tapas Deck', 'Rooftop bites - 2.1 km - 4.7', Icons.local_bar_rounded),
    ('Old Town Thali Lab', 'Comfort plates - 0.8 km - 4.9', Icons.rice_bowl_rounded),
    ('Coastal Spice Cart', 'Street seafood - 1.9 km - 4.6', Icons.set_meal_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final active = moods[mood];
    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mood Food Explorer', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(
            'AI blends your mood, weather, and local cravings.',
            style: TextStyle(color: adaptiveMutedColor(context, .62)),
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Row(
              children: [
                Icon(active['icon'] as IconData, color: active['color'] as Color, size: 38),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    '${active['label']} mode is active. Clear sky, 32 C, bright flavors recommended.',
                    style: const TextStyle(fontWeight: FontWeight.w800, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SectionHeader(title: 'Choose Mood'),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: moods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 640 ? 3 : 2,
              childAspectRatio: MediaQuery.of(context).size.width > 360 ? 1.45 : 1.25,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, i) {
              final m = moods[i];
              final selected = i == mood;
              return GlassCard(
                onTap: () => setState(() => mood = i),
                color: selected ? (m['color'] as Color).withOpacity(.24) : null,
                child: Row(
                  children: [
                    Icon(m['icon'] as IconData, color: m['color'] as Color),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        m['label'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SectionHeader(title: 'Recommended Restaurants'),
          ...foods.map(
            (f) => GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(colors: [(active['color'] as Color).withOpacity(.75), AppColors.primary]),
                    ),
                    child: Icon(f.$3, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.$1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          f.$2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: adaptiveMutedColor(context, .62), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded, color: AppColors.accent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
