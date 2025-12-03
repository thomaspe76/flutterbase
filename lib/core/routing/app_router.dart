import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/user/presentation/pages/user_profile_page.dart';

/// Centralized routing configuration using go_router.
/// This replaces the traditional Navigator 1.0 approach.
class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const UserProfilePage(),
      ),
      // Add more routes here as the app grows
      // Example:
      // GoRoute(
      //   path: '/settings',
      //   builder: (context, state) => const SettingsPage(),
      // ),
    ],
    // Error handler for unknown routes
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}
