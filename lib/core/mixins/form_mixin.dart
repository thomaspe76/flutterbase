import 'package:flutter/material.dart';

/// Mixin to standardize form handling.
/// Usage:
/// ```dart
/// class MyFormState extends State<MyForm> with FormMixin {
///   @override
///   void onSubmit() {
///     // Handle submission
///   }
/// }
/// ```
mixin FormMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();

  /// Override this to handle the actual submission logic.
  Future<void> onSubmit();

  /// Validates the form and calls [onSubmit] if valid.
  /// Returns true if submission was triggered.
  Future<bool> submit() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onSubmit();
      return true;
    }
    return false;
  }
}
