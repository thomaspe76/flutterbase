import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color_schemes.dart';

/// Zentrales Design-System & Theme Konfiguration.
///
/// Nutzt Material 3 und Google Fonts (Inter).
/// Definiert Light & Dark Mode basierend auf [AppColorSchemes].
class AppTheme {
  static final TextTheme _textTheme = GoogleFonts.interTextTheme();

  // === LIGHT THEME ===
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorSchemes.productivity.primary,
        brightness: Brightness.light,
        surface: AppColorSchemes.slate.s50,
        onSurface: AppColorSchemes.slate.s900,
      ),
      textTheme: _textTheme,
      scaffoldBackgroundColor: AppColorSchemes.slate.s50,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorSchemes.slate.s50,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: AppColorSchemes.slate.s900,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColorSchemes.slate.s200),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: AppColorSchemes.productivity.primary,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColorSchemes.slate.s200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColorSchemes.slate.s200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: AppColorSchemes.productivity.primary, width: 2),
        ),
      ),
    );
  }

  // === DARK THEME ===
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorSchemes.productivity.primary,
        brightness: Brightness.dark,
        surface: AppColorSchemes.slate.s900,
        onSurface: Colors.white,
      ),
      textTheme: _textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      scaffoldBackgroundColor:
          AppColorSchemes.slate.s950, // Custom darker shade
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorSchemes.slate.s900,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColorSchemes.slate.s800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColorSchemes.slate.s700),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: AppColorSchemes.productivity.primary,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorSchemes.slate.s800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColorSchemes.slate.s700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColorSchemes.slate.s700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: AppColorSchemes.productivity.primary, width: 2),
        ),
      ),
    );
  }
}

// Extension für s950 (nicht in ColorSchemes definiert)
extension on ({
  Color s100,
  Color s200,
  Color s300,
  Color s400,
  Color s50,
  Color s500,
  Color s600,
  Color s700,
  Color s800,
  Color s900
}) {
  Color get s950 => const Color(0xFF020617);
}
