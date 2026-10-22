import 'package:flutter/material.dart';

/// Exotica PCMC — Luxury Design System
/// Gold on Pitch Black — Cinematic Glassmorphism
class ExColors {
  ExColors._();

  // ─── Base ─────────────────────────────────────────────────────────────────
  static const Color void_ = Color(0xFF050505);       // Pure pitch black
  static const Color surface = Color(0xFF111111);
  static const Color surfaceGlass = Color(0xD9141414); // rgba(20,20,20,0.85)
  static const Color surfaceModal = Color(0xE6232323); // rgba(35,35,35,0.9)
  static const Color surfaceCard = Color(0xFF1A1A1A);
  static const Color border = Color(0x0DFFFFFF);       // rgba(255,255,255,0.05)
  static const Color borderGold = Color(0x33D4AF37);   // Gold 20%
  static const Color divider = Color(0x14FFFFFF);      // rgba(255,255,255,0.08)

  // ─── Gold Accent ──────────────────────────────────────────────────────────
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF2CA50);
  static const Color goldDim = Color(0xFFB8962E);
  static const Color goldText = Color(0xFFE9C349);

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFE5E2E1);
  static const Color textSecondary = Color(0xFFD0C5AF);
  static const Color textMuted = Color(0xFF99907C);

  // ─── Status ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF166534);
  static const Color error = Color(0xFF93000A);

  // ─── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF2CA50), Color(0xFFD4AF37)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient voidGradient = LinearGradient(
    colors: [Color(0xFF050505), Color(0xFF0E0E0E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── Shadows ──────────────────────────────────────────────────────────────
  static const List<BoxShadow> goldGlow = [
    BoxShadow(
      color: Color(0x26D4AF37), // 15% opacity
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x80000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
}
