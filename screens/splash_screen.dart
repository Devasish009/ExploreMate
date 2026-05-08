import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'home_screen.dart';
import '../app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Logo pop-in
  late AnimationController _logoCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _logoFadeAnim;

  // Subtitle / progress reveal
  late AnimationController _textCtrl;
  late Animation<double> _textFadeAnim;
  late Animation<Offset> _textSlideAnim;

  // Ripple rings
  late AnimationController _rippleCtrl;

  // Exit fade
  late AnimationController _exitCtrl;
  late Animation<double> _exitFadeAnim;

  @override
  void initState() {
    super.initState();

    // ── Logo ──────────────────────────────────────────────────────────────
    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnim = Tween<double>(begin: 0.25, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut),
    );
    _logoFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoCtrl, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    // ── Text ─────────────────────────────────────────────────────────────
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textCtrl, curve: Curves.easeIn),
    );
    _textSlideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));

    // ── Ripple ───────────────────────────────────────────────────────────
    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    // ── Exit ─────────────────────────────────────────────────────────────
    _exitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _exitFadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitCtrl, curve: Curves.easeInOut),
    );

    // Sequencing
    _logoCtrl.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _textCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 3000), () async {
      if (!mounted) return;
      await _exitCtrl.forward();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 450),
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    _rippleCtrl.dispose();
    _exitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _exitFadeAnim,
      builder: (_, child) => Opacity(opacity: _exitFadeAnim.value, child: child),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryDeep,
                Color(0xFF256E6C),
                AppColors.primary,
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // ── Ripple rings ─────────────────────────────────────────
              AnimatedBuilder(
                animation: _rippleCtrl,
                builder: (_, __) => CustomPaint(
                  size: Size.infinite,
                  painter: _RipplePainter(_rippleCtrl.value),
                ),
              ),

              // ── Decorative blobs ─────────────────────────────────────
              Positioned(
                top: -80,
                right: -80,
                child: _blob(220, AppColors.accent.withOpacity(0.08)),
              ),
              Positioned(
                bottom: -60,
                left: -60,
                child: _blob(200, AppColors.primaryDeep.withOpacity(0.3)),
              ),

              // ── Main content ─────────────────────────────────────────
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Logo icon
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: FadeTransition(
                        opacity: _logoFadeAnim,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow ring
                            Container(
                              width: 134,
                              height: 134,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.06),
                              ),
                            ),
                            // Logo card
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.28),
                                    Colors.white.withOpacity(0.10),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.35),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.45),
                                    blurRadius: 36,
                                    spreadRadius: 4,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.explore_rounded,
                                size: 58,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // App name + tagline
                    SlideTransition(
                      position: _textSlideAnim,
                      child: FadeTransition(
                        opacity: _textFadeAnim,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  const LinearGradient(
                                colors: [Colors.white, Color(0xFFB5E5DF)],
                              ).createShader(bounds),
                              child: const Text(
                                'ExploreMate',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your AI Travel Companion',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.72),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Loading bar
                    FadeTransition(
                      opacity: _textFadeAnim,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                backgroundColor:
                                    Colors.white.withOpacity(0.18),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.accent.withOpacity(0.9),
                                ),
                                minHeight: 3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Discovering the world…',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 11,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

/// Animated concentric ripple rings centred on screen.
class _RipplePainter extends CustomPainter {
  final double progress;
  _RipplePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.40);
    final maxRadius = size.width * 0.75;

    for (int i = 0; i < 4; i++) {
      final wave = (progress + i * 0.25) % 1.0;
      final radius = maxRadius * wave;
      final opacity = (1.0 - wave) * 0.12;

      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.white.withOpacity(opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
    }
  }

  @override
  bool shouldRepaint(_RipplePainter old) => old.progress != progress;
}
