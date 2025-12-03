import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricGuard extends StatefulWidget {
  final Widget child;
  final Widget? lockedChild;
  final String reason;

  const BiometricGuard({
    super.key,
    required this.child,
    this.lockedChild,
    this.reason = 'Please authenticate to access this feature',
  });

  @override
  State<BiometricGuard> createState() => _BiometricGuardState();
}

class _BiometricGuardState extends State<BiometricGuard> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false;
  bool _canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });

    if (_canCheckBiometrics) {
      _authenticate();
    } else {
      // Fallback if no biometrics: allow access or show error?
      // For now, allow access if no hardware available, but in prod you might want a PIN fallback.
      setState(() {
        _isAuthenticated = true;
      });
    }
  }

  Future<void> _authenticate() async {
    try {
      final authenticated = await auth.authenticate(
        localizedReason: widget.reason,
      );
      setState(() {
        _isAuthenticated = authenticated;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isAuthenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return widget.child;
    }

    return widget.lockedChild ??
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 64),
              const SizedBox(height: 16),
              Text(widget.reason),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _authenticate,
                child: const Text('Unlock'),
              ),
            ],
          ),
        );
  }
}
