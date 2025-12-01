import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized typography definitions for the application.
/// Never use hardcoded font sizes or text styles in widgets - always reference these constants.
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Inter';

  // Font Sizes
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 30.0;
  static const double fontSize4xl = 36.0;
  static const double fontSize5xl = 48.0;

  // Font Weights
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;

  // Display Styles
  static const TextStyle display1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize5xl,
    fontWeight: fontWeightBold,
    height: lineHeightTight,
    color: AppColors.textPrimary,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize4xl,
    fontWeight: fontWeightBold,
    height: lineHeightTight,
    color: AppColors.textPrimary,
  );

  // Heading Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize3xl,
    fontWeight: fontWeightBold,
    height: lineHeightTight,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize2xl,
    fontWeight: fontWeightSemiBold,
    height: lineHeightTight,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeXl,
    fontWeight: fontWeightSemiBold,
    height: lineHeightNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeLg,
    fontWeight: fontWeightMedium,
    height: lineHeightNormal,
    color: AppColors.textPrimary,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeLg,
    fontWeight: fontWeightRegular,
    height: lineHeightNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeMd,
    fontWeight: fontWeightRegular,
    height: lineHeightNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeSm,
    fontWeight: fontWeightRegular,
    height: lineHeightNormal,
    color: AppColors.textSecondary,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeMd,
    fontWeight: fontWeightMedium,
    height: lineHeightNormal,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeSm,
    fontWeight: fontWeightMedium,
    height: lineHeightNormal,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeXs,
    fontWeight: fontWeightMedium,
    height: lineHeightNormal,
    color: AppColors.textSecondary,
  );

  // Button Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeMd,
    fontWeight: fontWeightSemiBold,
    height: lineHeightTight,
    color: AppColors.textOnPrimary,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeSm,
    fontWeight: fontWeightSemiBold,
    height: lineHeightTight,
    color: AppColors.textOnPrimary,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeXs,
    fontWeight: fontWeightSemiBold,
    height: lineHeightTight,
    color: AppColors.textOnPrimary,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeXs,
    fontWeight: fontWeightRegular,
    height: lineHeightNormal,
    color: AppColors.textTertiary,
  );

  // Overline
  static const TextStyle overline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSizeXs,
    fontWeight: fontWeightMedium,
    height: lineHeightNormal,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );
}
