import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ex_colors.dart';

/// Exotica PCMC Typography
/// Libre Caslon Text (serif) + Inter (sans-serif)
class ExTypography {
  ExTypography._();

  // ─── Serif — Brand / Product Titles ──────────────────────────────────────
  static TextStyle caslon({
    double size = 24,
    FontWeight weight = FontWeight.w400,
    Color color = ExColors.textPrimary,
    double? letterSpacing,
    double height = 1.3,
  }) =>
      GoogleFonts.libreCaslonText(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  // ─── Sans — UI / Functional ───────────────────────────────────────────────
  static TextStyle inter({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = ExColors.textSecondary,
    double? letterSpacing,
    double height = 1.5,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  // ─── Named Styles ─────────────────────────────────────────────────────────
  static TextStyle get displayLg => caslon(size: 32, letterSpacing: -0.01 * 32, height: 1.18);
  static TextStyle get headlineMd => caslon(size: 24, height: 1.33);
  static TextStyle get titleLg => inter(size: 18, weight: FontWeight.w600, color: ExColors.textPrimary, letterSpacing: 0.02 * 18);
  static TextStyle get bodyLg => inter(size: 16, color: ExColors.textSecondary);
  static TextStyle get bodySm => inter(size: 14, color: ExColors.textMuted);
  static TextStyle get labelCaps => inter(size: 12, weight: FontWeight.w700, color: ExColors.textMuted, letterSpacing: 0.1 * 12);
  static TextStyle get price => inter(size: 20, weight: FontWeight.w700, color: ExColors.goldText);
  static TextStyle get priceLg => inter(size: 28, weight: FontWeight.w700, color: ExColors.goldText);
  static TextStyle get brandName => caslon(size: 24, weight: FontWeight.w700, color: ExColors.gold, letterSpacing: 0.06 * 24);
  static TextStyle get navLabel => inter(size: 11, weight: FontWeight.w500, color: ExColors.textMuted);
  static TextStyle get buttonLabel => inter(size: 15, weight: FontWeight.w700, color: ExColors.void_, letterSpacing: 0.06 * 15);
  static TextStyle get tag => inter(size: 11, weight: FontWeight.w700, color: ExColors.gold, letterSpacing: 0.1 * 11);
}
