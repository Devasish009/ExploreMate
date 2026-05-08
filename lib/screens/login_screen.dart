import 'dart:ui';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../widgets/premium_widgets.dart';

enum AuthMode { login, signup, otp, forgot }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool obscureText = true;
  bool rememberMe = true;
  AuthMode mode = AuthMode.login;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 380;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/mountain_bg.png', fit: BoxFit.cover)),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primaryDeep.withOpacity(.28), AppColors.surface.withOpacity(.92)],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: isCompact ? 18 : 24, vertical: 24),
                child: FadeTransition(
                  opacity: CurvedAnimation(parent: controller, curve: Curves.easeOut),
                  child: SlideTransition(
                    position: Tween(begin: const Offset(0, .08), end: Offset.zero)
                        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic)),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo.png', height: isCompact ? 88 : 116, fit: BoxFit.contain),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                              child: Container(
                                padding: EdgeInsets.all(isCompact ? 22 : 30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(color: Colors.white.withOpacity(0.28)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryDeep.withOpacity(.45),
                                      blurRadius: 34,
                                      offset: const Offset(0, 22),
                                    ),
                                  ],
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 260),
                                  child: _buildModeContent(key: ValueKey(mode)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeContent({required Key key}) {
    switch (mode) {
      case AuthMode.signup:
        return _AuthPanel(
          key: key,
          title: 'Create explorer ID',
          subtitle: 'Sync AI trips, badges, and saved places.',
          fields: [
            _buildTextField(hint: 'Full name'),
            _buildTextField(hint: 'Email address'),
            _buildTextField(hint: 'Password', isPassword: true),
          ],
          primary: 'CREATE ACCOUNT',
          primaryTap: () => setState(() => mode = AuthMode.otp),
          footer: _footer('Already onboard?', 'Sign in', () => setState(() => mode = AuthMode.login)),
        );
      case AuthMode.otp:
        return _AuthPanel(
          key: key,
          title: 'Verify your signal',
          subtitle: 'Enter the 6 digit code sent to your email.',
          fields: [_buildTextField(hint: '123456', keyboard: TextInputType.number)],
          primary: 'VERIFY OTP',
          primaryTap: _goHome,
          footer: _footer('Need another code?', 'Resend', () {}),
        );
      case AuthMode.forgot:
        return _AuthPanel(
          key: key,
          title: 'Reset access',
          subtitle: 'We will send a secure recovery link.',
          fields: [_buildTextField(hint: 'Email address')],
          primary: 'SEND RESET LINK',
          primaryTap: () => setState(() => mode = AuthMode.login),
          footer: _footer('Remembered it?', 'Sign in', () => setState(() => mode = AuthMode.login)),
        );
      case AuthMode.login:
        return _AuthPanel(
          key: key,
          title: 'Have an account?',
          subtitle: 'Welcome back, explorer.',
          fields: [
            _buildTextField(hint: 'bernand.firman@gmail.com'),
            _buildTextField(
              hint: 'Password',
              isPassword: true,
              suffix: IconButton(
                icon: Icon(obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded, color: Colors.black54),
                onPressed: () => setState(() => obscureText = !obscureText),
              ),
            ),
          ],
          primary: 'SIGN IN',
          primaryTap: _goHome,
          extra: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: AppColors.accent,
                    checkColor: AppColors.primaryDeep,
                    onChanged: (v) => setState(() => rememberMe = v ?? false),
                  ),
                  const Text('Remember Me', style: TextStyle(color: Colors.white, fontSize: 12)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setState(() => mode = AuthMode.forgot),
                    child: const Text('Forgot Password', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('- Or Sign In With -', style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 12)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _social('Facebook', const Color(0xFF4267B2), Colors.white)),
                  const SizedBox(width: 14),
                  Expanded(child: _social('Google', Colors.white, Colors.black87)),
                ],
              ),
            ],
          ),
          footer: _footer('New to ExploreMate?', 'Create account', () => setState(() => mode = AuthMode.signup)),
        );
    }
  }

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    TextInputType? keyboard,
    Widget? suffix,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(.42)),
      ),
      child: TextField(
        obscureText: isPassword && obscureText,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _social(String text, Color bg, Color fg) {
    return SizedBox(
      height: 46,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _footer(String a, String b, VoidCallback tap) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(a, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          TextButton(onPressed: tap, child: Text(b)),
        ],
      ),
    );
  }

  void _goHome() => Navigator.pushReplacementNamed(context, '/home');
}

class _AuthPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> fields;
  final String primary;
  final VoidCallback primaryTap;
  final Widget? extra;
  final Widget footer;

  const _AuthPanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.primary,
    required this.primaryTap,
    required this.footer,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 24),
        ...fields,
        SizedBox(
          width: double.infinity,
          child: GradientButton(label: primary, icon: Icons.arrow_forward_rounded, onPressed: primaryTap),
        ),
        if (extra != null) extra!,
        footer,
      ],
    );
  }
}
