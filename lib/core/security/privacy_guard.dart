import 'dart:ui';
import 'package:flutter/material.dart';

class PrivacyGuard extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const PrivacyGuard({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  State<PrivacyGuard> createState() => _PrivacyGuardState();
}

class _PrivacyGuardState extends State<PrivacyGuard>
    with WidgetsBindingObserver {
  bool _showBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.enabled) return;

    setState(() {
      _showBlur = state == AppLifecycleState.paused ||
          state == AppLifecycleState.inactive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showBlur)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Theme.of(context)
                    .colorScheme
                    .surface
                    .withAlpha((255 * 0.8).round()),
                alignment: Alignment.center,
                child: const Icon(Icons.lock, size: 80, color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}
