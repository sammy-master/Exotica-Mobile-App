import 'package:flutter/material.dart';
import 'ex_colors.dart';
import 'ex_typography.dart';

class ExTheme {
  ExTheme._();

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ExColors.void_,
        colorScheme: const ColorScheme.dark(
          primary: ExColors.gold,
          onPrimary: ExColors.void_,
          secondary: ExColors.goldDim,
          surface: ExColors.surface,
          onSurface: ExColors.textPrimary,
          error: Color(0xFFEF4444),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: ExColors.textPrimary),
          titleTextStyle: ExTypography.brandName,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ExColors.surfaceGlass,
          selectedItemColor: ExColors.gold,
          unselectedItemColor: ExColors.textMuted,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: ExTypography.navLabel.copyWith(color: ExColors.gold),
          unselectedLabelStyle: ExTypography.navLabel,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ExColors.surfaceGlass,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ExColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ExColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ExColors.gold, width: 1.5),
          ),
          hintStyle: ExTypography.bodySm.copyWith(color: ExColors.textMuted),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        dividerTheme: const DividerThemeData(
          color: ExColors.divider,
          thickness: 1,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ExColors.surfaceModal,
          contentTextStyle: ExTypography.bodySm.copyWith(color: ExColors.textPrimary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
