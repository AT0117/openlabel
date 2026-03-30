import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// OpenLabel design tokens — OLED dark, neon accents, Inter typography.
abstract final class OpenLabelTheme {
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color border = Color(0xFF333333);
  static const Color neonGreen = Color(0xFF00FF66);
  static const Color electricRed = Color(0xFFFF3366);
  static const Color warningYellow = Color(0xFFFFCC00);
  static const Color bodyGrey = Color(0xFFD1D5DB); // grey-300

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );

    // Plus Jakarta Sans has strong Devanagari coverage and stays legible at
    // compact Bento-box sizes.
    final typed = GoogleFonts.plusJakartaSansTextTheme(base.textTheme);

    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        surface: surface,
        primary: neonGreen,
        secondary: electricRed,
        tertiary: warningYellow,
        onSurface: bodyGrey,
        outline: border,
      ),
      textTheme: typed.copyWith(
        headlineLarge: typed.headlineLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1.2,
          height: 1.05,
          color: Colors.white,
        ),
        headlineMedium: typed.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
          height: 1.1,
          color: Colors.white,
        ),
        titleLarge: typed.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
          color: Colors.white,
        ),
        titleMedium: typed.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: typed.bodyLarge?.copyWith(
          color: bodyGrey,
          height: 1.45,
        ),
        bodyMedium: typed.bodyMedium?.copyWith(
          color: bodyGrey,
          height: 1.45,
        ),
        bodySmall: typed.bodySmall?.copyWith(
          color: bodyGrey.withValues(alpha: 0.85),
          height: 1.4,
        ),
        labelLarge: typed.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: neonGreen, width: 1.5),
        ),
        hintStyle: TextStyle(color: bodyGrey.withValues(alpha: 0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
