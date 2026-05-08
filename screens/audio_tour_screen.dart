import 'package:flutter/material.dart';
import '../app_colors.dart';

class AudioTourScreen extends StatefulWidget {
  const AudioTourScreen({super.key});

  @override
  State<AudioTourScreen> createState() => _AudioTourScreenState();
}

class _AudioTourScreenState extends State<AudioTourScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _progress = 0.35;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  final List<Map<String, dynamic>> _nearbyTours = [
    {'name': 'Gateway of India', 'location': 'Mumbai', 'duration': '12 min', 'icon': Icons.account_balance_rounded},
    {'name': 'Golkonda Fort', 'location': 'Hyderabad', 'duration': '18 min', 'icon': Icons.castle_rounded},
    {'name': 'Borra Caves', 'location': 'Vizag', 'duration': '10 min', 'icon': Icons.terrain_rounded},
    {'name': 'Charminar', 'location': 'Hyderabad', 'duration': '8 min', 'icon': Icons.mosque_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.9, end: 1.05).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _formatTime(double progress, int totalSeconds) {
    final elapsed = (progress * totalSeconds).toInt();
    final m = elapsed ~/ 60;
    final s = elapsed % 60;
    return '${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('AI Audio Tour'),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.language_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildNowPlaying(),
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 10, 14, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('MORE TOURS NEARBY',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600,
                      color: AppColors.primary, letterSpacing: 0.8)),
            ),
          ),
          Expanded(child: _buildTourList()),
        ],
      ),
    );
  }

  Widget _buildNowPlaying() {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, child) => Transform.scale(
              scale: _isPlaying ? _pulseAnim.value : 1.0,
              child: child,
            ),
            child: Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.audiotrack_rounded, color: AppColors.accent, size: 36),
            ),
          ),
          const SizedBox(height: 14),
          const Text('Gateway of India',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Mumbai · English · 12 min',
              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: Colors.white24,
              thumbColor: AppColors.accent,
              overlayColor: Colors.transparent,
            ),
            child: Slider(
              value: _progress,
              onChanged: (v) => setState(() => _progress = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatTime(_progress, 720),
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10)),
                Text('12:00',
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlBtn(Icons.skip_previous_rounded, false, () {}),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => setState(() => _isPlaying = !_isPlaying),
                child: Container(
                  width: 52, height: 52,
                  decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: AppColors.primaryDeep, size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              _controlBtn(Icons.skip_next_rounded, false, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _controlBtn(IconData icon, bool isPrimary, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white70, size: 18),
      ),
    );
  }

  Widget _buildTourList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _nearbyTours.length,
      itemBuilder: (_, i) {
        final t = _nearbyTours[i];
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
                decoration: BoxDecoration(color: AppColors.tileLight1, borderRadius: BorderRadius.circular(10)),
                child: Icon(t['icon'] as IconData, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t['name'] as String,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
                    Text('${t['location']} · ${t['duration']}',
                        style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tileLight1,
                    foregroundColor: AppColors.primaryDark,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text('Start', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        );
      },
    );
  }
}
