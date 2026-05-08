import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController orbit;
  late final AnimationController reveal;

  @override
  void initState() {
    super.initState();
    orbit = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    reveal = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
    Timer(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    orbit.dispose();
    reveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.auroraGradient),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: orbit,
              builder: (_, __) => CustomPaint(size: Size.infinite, painter: _OrbitPainter(orbit.value)),
            ),
            Center(
              child: ScaleTransition(
                scale: CurvedAnimation(parent: reveal, curve: Curves.easeOutBack),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 118,
                      height: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: Colors.white.withOpacity(0.12),
                        border: Border.all(color: Colors.white30),
                        boxShadow: [BoxShadow(color: AppColors.accent.withOpacity(.34), blurRadius: 42)],
                      ),
                      child: const Icon(Icons.explore_rounded, color: Colors.white, size: 66),
                    ),
                    const SizedBox(height: 28),
                    const Text('ExploreMate', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    const Text('AI travel intelligence online', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 34),
                    const SizedBox(width: 160, child: LinearProgressIndicator(minHeight: 3, color: AppColors.accent)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  final double progress;
  _OrbitPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 40);
    for (var i = 0; i < 5; i++) {
      final radius = 92.0 + i * 42;
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.white.withOpacity(.05),
      );
      final angle = progress * math.pi * 2 + i * .9;
      final dot = Offset(center.dx + math.cos(angle) * radius, center.dy + math.sin(angle) * radius);
      canvas.drawCircle(dot, 3.5, Paint()..color = i.isEven ? AppColors.accent : AppColors.secondary);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) => oldDelegate.progress != progress;
}
