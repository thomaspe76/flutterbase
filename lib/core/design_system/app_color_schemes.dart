import 'package:flutter/material.dart';

/// Vordefinierte Farbschemata für verschiedene App-Typen.
///
/// Verwendung:
/// 1. Schema wählen: final colors = AppColorSchemes.finance;
/// 2. In AppColors übernehmen oder direkt verwenden
///
/// Farbpsychologie:
/// - Emerald/Grün: Geld, Wachstum, Erfolg (Finance, Health)
/// - Blue: Vertrauen, Stabilität, Professionalität (Business, Tech)
/// - Purple/Indigo: Premium, Kreativität, Luxus (Premium Features)
/// - Orange/Amber: Energie, Warnung, Aufmerksamkeit (CTA, Alerts)
/// - Red: Dringlichkeit, Fehler, Stop (Errors, Limits)
abstract class AppColorSchemes {
  /// Finance/Budget Apps - Emerald + Slate
  static const finance = (
    primary: Color(0xFF10B981), // Emerald 500
    primaryLight: Color(0xFF34D399), // Emerald 400
    primaryDark: Color(0xFF059669), // Emerald 600
    primarySurface: Color(0xFFD1FAE5), // Emerald 100
    secondary: Color(0xFF6366F1), // Indigo (Premium)
    accent: Color(0xFFF59E0B), // Amber (Warnings)
  );

  /// Productivity/Task Apps - Blue + Slate
  static const productivity = (
    primary: Color(0xFF3B82F6), // Blue 500
    primaryLight: Color(0xFF60A5FA), // Blue 400
    primaryDark: Color(0xFF2563EB), // Blue 600
    primarySurface: Color(0xFFDBEAFE), // Blue 100
    secondary: Color(0xFF8B5CF6), // Violet (Premium)
    accent: Color(0xFFF97316), // Orange (CTA)
  );

  /// Health/Fitness Apps - Teal + Slate
  static const health = (
    primary: Color(0xFF14B8A6), // Teal 500
    primaryLight: Color(0xFF2DD4BF), // Teal 400
    primaryDark: Color(0xFF0D9488), // Teal 600
    primarySurface: Color(0xFFCCFBF1), // Teal 100
    secondary: Color(0xFFEC4899), // Pink (Premium)
    accent: Color(0xFFF59E0B), // Amber (Goals)
  );

  /// Utility/Tools Apps - Slate + Accent
  static const utility = (
    primary: Color(0xFF475569), // Slate 600
    primaryLight: Color(0xFF64748B), // Slate 500
    primaryDark: Color(0xFF334155), // Slate 700
    primarySurface: Color(0xFFF1F5F9), // Slate 100
    secondary: Color(0xFF3B82F6), // Blue (Actions)
    accent: Color(0xFF10B981), // Emerald (Success)
  );

  /// Gemeinsame Semantic Colors (für alle Schemes)
  static const semantic = (
    success: Color(0xFF10B981),
    successLight: Color(0xFFD1FAE5),
    warning: Color(0xFFF59E0B),
    warningLight: Color(0xFFFEF3C7),
    error: Color(0xFFEF4444),
    errorLight: Color(0xFFFEE2E2),
    info: Color(0xFF3B82F6),
    infoLight: Color(0xFFDBEAFE),
  );

  /// Slate Neutral Palette (für alle Schemes)
  static const slate = (
    s900: Color(0xFF0F172A),
    s800: Color(0xFF1E293B),
    s700: Color(0xFF334155),
    s600: Color(0xFF475569),
    s500: Color(0xFF64748B),
    s400: Color(0xFF94A3B8),
    s300: Color(0xFFCBD5E1),
    s200: Color(0xFFE2E8F0),
    s100: Color(0xFFF1F5F9),
    s50: Color(0xFFF8FAFC),
  );

  /// Kategorie-Farben für Charts (12 Farben)
  static const List<Color> chartColors = [
    Color(0xFF10B981), // Emerald
    Color(0xFF3B82F6), // Blue
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
    Color(0xFFF97316), // Orange
    Color(0xFF84CC16), // Lime
    Color(0xFF6366F1), // Indigo
    Color(0xFF14B8A6), // Teal
    Color(0xFFA855F7), // Purple
  ];
}
