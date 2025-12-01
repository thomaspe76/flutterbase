/// Centralized spacing definitions for the application.
/// Never use hardcoded spacing values in widgets - always reference these constants.
class AppSpacing {
  AppSpacing._();

  // Base spacing unit (4px)
  static const double base = 4.0;

  // Predefined spacing values
  static const double xxxs = base * 0.5; // 2px
  static const double xxs = base; // 4px
  static const double xs = base * 2; // 8px
  static const double sm = base * 3; // 12px
  static const double md = base * 4; // 16px
  static const double lg = base * 6; // 24px
  static const double xl = base * 8; // 32px
  static const double xxl = base * 10; // 40px
  static const double xxxl = base * 12; // 48px

  // Specific use cases
  static const double buttonPaddingHorizontal = md;
  static const double buttonPaddingVertical = sm;
  static const double cardPadding = md;
  static const double screenPadding = md;
  static const double sectionSpacing = lg;
  static const double listItemSpacing = xs;
  static const double iconTextGap = xs;
  static const double inputPadding = sm;

  // Border Radius
  static const double radiusXs = xxs;
  static const double radiusSm = xs;
  static const double radiusMd = sm;
  static const double radiusLg = md;
  static const double radiusXl = lg;
  static const double radiusFull = 9999;
}
