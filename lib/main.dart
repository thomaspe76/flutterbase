import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/design_system/app_theme.dart';
import 'core/di/injection.dart';
import 'l10n/app_localizations.dart';
import 'features/user/presentation/pages/user_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await initializeDependencies();

  runApp(
    // ProviderScope is required for Riverpod
    const ProviderScope(
      child: FlutterBaseApp(),
    ),
  );
}

/// Root widget of the application.
/// Demonstrates proper setup with localization and theme.
class FlutterBaseApp extends StatelessWidget {
  const FlutterBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBase',
      debugShowCheckedModeBanner: false,

      // Theme configuration using our design system
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,

      // Localization configuration
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('de'), // Default to German

      // Home page
      home: const UserProfilePage(),
    );
  }
}
