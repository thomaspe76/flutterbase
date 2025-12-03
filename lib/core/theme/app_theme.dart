import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'semantic_colors.dart';

class AppTheme {
  static ThemeData lightTheme(
    Color seedColor, {
    ColorScheme? dynamicColorScheme,
  }) {
    final colorScheme = dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.outfitTextTheme(),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorShape: StadiumBorder(),
      ),
      extensions: const [SemanticColors.light],
    );
  }

  static ThemeData darkTheme(
    Color seedColor, {
    ColorScheme? dynamicColorScheme,
  }) {
    final colorScheme = dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorShape: StadiumBorder(),
      ),
      extensions: const [SemanticColors.dark],
    );
  }
}
