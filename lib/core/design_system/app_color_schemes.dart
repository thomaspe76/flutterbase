import 'package:flutter/material.dart';

/// Vordefinierte Farbschemata für verschiedene App-Kategorien.
///
/// Farbpsychologie:
/// - Emerald: Geld, Wachstum, Erfolg (Finance, Health)
/// - Blue: Vertrauen, Stabilität, Professionalität (Business, Productivity)
/// - Indigo/Purple: Premium, Kreativität, Luxus (Pro Features)
/// - Amber: Energie, Warnung (CTAs, Alerts)
/// - Red: Dringlichkeit, Fehler (Errors, Limits)
abstract class AppColorSchemes {
  // === FINANCE (Emerald + Slate) ===
  static const finance = (
    primary: Color(0xFF10B981),
    primaryLight: Color(0xFF34D399),
    primaryDark: Color(0xFF059669),
    primarySurface: Color(0xFFD1FAE5),
    secondary: Color(0xFF6366F1),
    accent: Color(0xFFF59E0B),
  );

  // === PRODUCTIVITY (Blue + Slate) ===
  static const productivity = (
    primary: Color(0xFF3B82F6),
    primaryLight: Color(0xFF60A5FA),
    primaryDark: Color(0xFF2563EB),
    primarySurface: Color(0xFFDBEAFE),
    secondary: Color(0xFF8B5CF6),
    accent: Color(0xFFF97316),
  );

  // === HEALTH (Teal + Slate) ===
  static const health = (
    primary: Color(0xFF14B8A6),
    primaryLight: Color(0xFF2DD4BF),
    primaryDark: Color(0xFF0D9488),
    primarySurface: Color(0xFFCCFBF1),
    secondary: Color(0xFFEC4899),
    accent: Color(0xFFF59E0B),
  );

  // === UTILITY (Slate) ===
  static const utility = (
    primary: Color(0xFF475569),
    primaryLight: Color(0xFF64748B),
    primaryDark: Color(0xFF334155),
    primarySurface: Color(0xFFF1F5F9),
    secondary: Color(0xFF3B82F6),
    accent: Color(0xFF10B981),
  );

  // === SEMANTIC COLORS (alle Schemes) ===
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

  // === SLATE NEUTRAL PALETTE ===
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

  // === CHART COLORS (12) ===
  static const List<Color> chartColors = [
    Color(0xFF10B981),
    Color(0xFF3B82F6),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
    Color(0xFFF97316),
    Color(0xFF84CC16),
    Color(0xFF6366F1),
    Color(0xFF14B8A6),
    Color(0xFFA855F7),
  ];
}
