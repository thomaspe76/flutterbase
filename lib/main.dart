import 'dart:async';
import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/design_system/app_theme.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    // Note: User must run `flutterfire configure` to generate firebase_options.dart
    // with valid keys. The current file is a placeholder.
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Load environment variables
      await dotenv.load(fileName: ".env");

      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    } catch (e) {
      // Fallback if Firebase is not configured properly (e.g. during initial setup)
      if (kDebugMode) {
        print('Firebase initialization failed: $e');
      }
    }

    // Initialize dependency injection
    await initializeDependencies();

    runApp(
      // ProviderScope is required for Riverpod
      const ProviderScope(
        child: FlutterBaseApp(),
      ),
    );
  }, (error, stack) {
    // Catch any errors that occur outside of the Flutter context
    if (Firebase.apps.isNotEmpty) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else {
      if (kDebugMode) {
        print('Uncaught error: $error');
      }
    }
  });
}

/// Root widget of the application.
/// Demonstrates proper setup with localization and theme.
class FlutterBaseApp extends StatelessWidget {
  const FlutterBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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

      // Router configuration
      routerConfig: AppRouter.router,

      // Accessibility tooling (only in debug mode)
      builder: (context, child) {
        if (kDebugMode) {
          return AccessibilityTools(
            child: child,
          );
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
