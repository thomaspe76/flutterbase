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
import 'core/services/hive_service.dart';
import 'core/services/ad_service.dart';
import 'core/services/feature_flag_service.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 1. Environment
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      debugPrint('[Main] No .env file');
    }

    // 2. Firebase + Crashlytics
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Crashlytics Error Handler
      FlutterError.onError = (details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      debugPrint('[Main] Firebase initialized');
    } catch (e) {
      debugPrint('[Main] Firebase failed: $e');
    }

    // 3. Hive
    await HiveService.initialize();

    // 4. AdMob
    await AdService.initialize();

    // 5. Feature Flags
    final featureFlagService = FeatureFlagService();
    await featureFlagService.initialize();

    // 6. Dependency Injection
    await initializeDependencies();

    // 7. Run App
    runApp(
      ProviderScope(
        overrides: [
          featureFlagServiceProvider.overrideWithValue(featureFlagService),
        ],
        child: const FlutterBaseApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('[Main] Uncaught: $error');
    if (Firebase.apps.isNotEmpty) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}

class FlutterBaseApp extends StatelessWidget {
  const FlutterBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FlutterBase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('de'),
      routerConfig: AppRouter.router,
      builder: (context, child) {
        if (kDebugMode) {
          return AccessibilityTools(child: child);
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
