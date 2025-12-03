import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Toast-Typen für verschiedene Anwendungsfälle
enum ToastType {
  success,
  error,
  info,
  warning,
}

/// Zentraler Service für einheitliche Toast-Notifications
///
/// Nutzt moderne, abgerundete Floating-Snackbars statt der Standard-SnackBars.
class ToastService {
  /// Zeigt einen Toast mit dem angegebenen Typ
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    // Farben und Icons basierend auf Toast-Typ
    final (backgroundColor, foregroundColor, icon) = switch (type) {
      ToastType.success => (
          const Color(0xFF10B981), // Emerald-500
          Colors.white,
          Icons.check_circle_rounded,
        ),
      ToastType.error => (
          const Color(0xFFEF4444), // Red-500
          Colors.white,
          Icons.error_rounded,
        ),
      ToastType.warning => (
          const Color(0xFFF59E0B), // Amber-500
          Colors.white,
          Icons.warning_rounded,
        ),
      ToastType.info => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
          Icons.info_rounded,
        ),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: foregroundColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: duration,
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: foregroundColor,
                onPressed: onAction ?? () {},
              )
            : null,
      ),
    );
  }

  /// Shortcut für Success-Toast
  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context,
        message: message, type: ToastType.success, duration: duration);
  }

  /// Shortcut für Error-Toast
  static void error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    show(context, message: message, type: ToastType.error, duration: duration);
  }

  /// Shortcut für Info-Toast
  static void info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context, message: message, type: ToastType.info, duration: duration);
  }

  /// Shortcut für Warning-Toast
  static void warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(context,
        message: message, type: ToastType.warning, duration: duration);
  }
}

/// Riverpod Provider für ToastService (falls benötigt)
final toastServiceProvider = Provider<ToastService>((ref) => ToastService());
