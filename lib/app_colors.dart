import 'package:flutter/material.dart';

/// ExploreMate — Ocean Blue Palette
/// Seed colour: #439F9D
class AppColors {
  AppColors._();

  // ── Primary ocean blue shades ──────────────────────────────────────────────
  static const Color primary      = Color(0xFF439F9D); // #439F9D — brand primary
  static const Color primaryDark  = Color(0xFF2D7F7D); // darker variant (app bars)
  static const Color primaryDeep  = Color(0xFF1A5E5C); // deepest (splash, drawer)

  // ── Accent & highlight ─────────────────────────────────────────────────────
  static const Color accent       = Color(0xFF7ECFC2); // light teal accent
  static const Color accentLight  = Color(0xFFB5E5DF); // very light teal

  // ── Background surfaces ────────────────────────────────────────────────────
  static const Color surface      = Color(0xFFF0FAFA); // page background
  static const Color cardBg       = Color(0xFFFFFFFF); // card background

  // ── Tile backgrounds ───────────────────────────────────────────────────────
  static const Color tileLight1   = Color(0xFFE0F5F3);
  static const Color tileLight2   = Color(0xFFD4EFEC);
  static const Color tileLight3   = Color(0xFFC8EAE7);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textDark     = Color(0xFF0D2826); // primary text
  static const Color textMid      = Color(0xFF2D7F7D); // secondary text / labels
  static const Color textMuted    = Color(0xFF8AB8B6); // placeholder / muted

  // ── Border ─────────────────────────────────────────────────────────────────
  static const Color borderColor  = Color(0xFFB5E5DF);

  // ── Status & functional ────────────────────────────────────────────────────
  static const Color xpGold       = Color(0xFF7ECFC2);
  static const Color success      = Color(0xFF2D7F7D);

  // ── Gem card gradient colours ──────────────────────────────────────────────
  static const Color gemOcean1    = Color(0xFF1B5E5C);
  static const Color gemOcean2    = Color(0xFF2D7F7D);
  static const Color gemOcean3    = Color(0xFF0D4A48);

  // Backwards-compat aliases used in home_screen gem cards
  static const Color gemGreen1    = gemOcean1;
  static const Color gemGreen2    = gemOcean2;
  static const Color gemGreen3    = gemOcean3;

  // ── Map placeholder tint ───────────────────────────────────────────────────
  static const Color mapBg        = Color(0xFFB5E5DF); // ocean-tinted map bg
}
