import 'package:flutter/material.dart';

@immutable
class SemanticColors extends ThemeExtension<SemanticColors> {
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;

  const SemanticColors({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
  });

  @override
  SemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
  }) {
    return SemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  SemanticColors lerp(ThemeExtension<SemanticColors>? other, double t) {
    if (other is! SemanticColors) {
      return this;
    }
    return SemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }

  static const light = SemanticColors(
    success: Color(0xFF2E7D32),
    onSuccess: Colors.white,
    warning: Color(0xFFED6C02),
    onWarning: Colors.white,
    info: Color(0xFF0288D1),
    onInfo: Colors.white,
  );

  static const dark = SemanticColors(
    success: Color(0xFF66BB6A),
    onSuccess: Colors.black,
    warning: Color(0xFFFFA726),
    onWarning: Colors.black,
    info: Color(0xFF29B6F6),
    onInfo: Colors.black,
  );
}
