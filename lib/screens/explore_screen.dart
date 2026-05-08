import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/demo_data.dart';
import '../widgets/premium_widgets.dart';
import 'food_screen.dart';
import 'hidden_gems_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int chip = 0;
  final filters = ['All', 'Hidden gems', 'Food', 'Heritage', 'Adventure', 'Low crowd'];

  @override
  Widget build(BuildContext context) {
    return CinematicScaffold(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Smart Search', style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(
            'Find destinations, local food, and AI-ranked hidden gems.',
            style: TextStyle(color: adaptiveMutedColor(context, .62)),
          ),
          const SizedBox(height: 18),
          AnimatedSearchBar(hint: 'Try "rainy evening in Vizag"'),
          const SizedBox(height: 14),
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  selected: chip == i,
                  label: Text(filters[i]),
                  onSelected: (_) => setState(() => chip = i),
                ),
              ),
            ),
          ),
          const SectionHeader(title: 'Categories'),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 640 ? 4 : 2,
            childAspectRatio: MediaQuery.of(context).size.width > 360 ? 1.25 : 1.08,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _Category('Destinations', Icons.landscape_rounded, AppColors.accent, null),
              _Category('Food places', Icons.restaurant_rounded, AppColors.secondary, const FoodScreen()),
              _Category('Hidden gems', Icons.diamond_rounded, AppColors.xpGold, const HiddenGemsScreen()),
              _Category('Voice AI', Icons.mic_rounded, const Color(0xFF9C8CFF), null),
            ],
          ),
          const SectionHeader(title: 'Trending Places'),
          SizedBox(
            height: 310,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: destinations.length,
              itemBuilder: (_, i) => DestinationCard(item: destinations[i], width: 245),
            ),
          ),
          const SectionHeader(title: 'Live Map Preview'),
          GlassCard(
            padding: EdgeInsets.zero,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(colors: [Color(0xFF12324D), Color(0xFF0D1D31)]),
              ),
              child: Stack(
                children: [
                  Positioned.fill(child: CustomPaint(painter: _MapPainter())),
                  ...[
                    const Offset(.25, .35),
                    const Offset(.62, .25),
                    const Offset(.48, .68),
                    const Offset(.78, .56),
                  ].map(
                    (o) => Align(
                      alignment: Alignment(o.dx * 2 - 1, o.dy * 2 - 1),
                      child: const Icon(Icons.location_on_rounded, color: AppColors.secondary, size: 34),
                    ),
                  ),
                  const Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text('4 discoveries within 3.2 km', style: TextStyle(fontWeight: FontWeight.w900)),
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

class _Category extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Widget? screen;
  const _Category(this.label, this.icon, this.color, this.screen);

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: screen == null ? null : () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const Spacer(),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          Text(
            'AI ranked',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: adaptiveMutedColor(context, .56), fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(.08)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < 7; i++) {
      final y = size.height * (i + 1) / 8;
      canvas.drawLine(Offset(0, y), Offset(size.width, y + (i.isEven ? 24 : -18)), paint);
    }
    for (var i = 0; i < 6; i++) {
      final x = size.width * (i + 1) / 7;
      canvas.drawLine(Offset(x, 0), Offset(x + (i.isEven ? 18 : -12), size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
