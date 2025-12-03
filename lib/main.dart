import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterbase/l10n/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutterbase/core/config/env_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/security/privacy_guard.dart';
import 'core/network/supabase_provider.dart';
import 'features/settings/logic/settings_provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterbase/core/services/hive_service.dart';
import 'package:flutterbase/core/services/ad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Environment Variables
  try {
    await dotenv.load(fileName: ".env");
    EnvConfig.init(
      environment: dotenv.env['ENVIRONMENT'] == 'prod'
          ? Environment.prod
          : Environment.dev,
      apiBaseUrl: dotenv.env['API_BASE_URL'] ?? '',
      supabaseUrl: dotenv.env['SUPABASE_URL'] ?? '',
      supabaseAnonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
      geminiApiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
      sentryDsn: dotenv.env['SENTRY_DSN'] ?? '',
      enableLogging: dotenv.env['ENABLE_LOGGING'] == 'true',
    );
  } catch (e) {
    debugPrint('[Main] No .env file found or init failed: $e');
    // Fallback init
    EnvConfig.init(
      environment: Environment.dev,
      apiBaseUrl: '',
      supabaseUrl: '',
      supabaseAnonKey: '',
      geminiApiKey: '',
      sentryDsn: '',
    );
  }

  // 2. Hive (Local Storage)
  await HiveService.initialize();

  // 3. AdMob
  await AdService.initialize();

  final container = ProviderContainer();
  await container.read(initializeSupabaseProvider.future);

  await SentryFlutter.init(
    (options) {
      options.dsn = EnvConfig.instance.sentryDsn;
      options.tracesSampleRate = 1.0;
      options.environment = EnvConfig.instance.environment.name;
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: PrivacyGuard(
          child: MainApp(),
        ),
      ),
    ),
  );

  // Edge-to-Edge System UI
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settings = ref.watch(settingsProvider);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return PrivacyGuard(
          enabled: settings.privacyModeEnabled,
          child: MaterialApp.router(
            title: 'Flutter Boilerplate',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('de'),
            ],
            theme: AppTheme.lightTheme(
              Color(settings.themeColor),
              dynamicColorScheme: lightDynamic,
            ),
            darkTheme: AppTheme.darkTheme(
              Color(settings.themeColor),
              dynamicColorScheme: darkDynamic,
            ),
            themeMode: settings.themeMode,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
