import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/env_config.dart';
import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const config = EnvConfig(
    environment: Environment.dev,
    apiBaseUrl: 'https://api.dev.example.com',
    supabaseUrl: 'https://your-project.supabase.co',
    supabaseAnonKey: 'your-anon-key',
    geminiApiKey: 'your-gemini-api-key',
    sentryDsn: 'your-sentry-dsn',
    enableLogging: true,
  );

  EnvConfig.init(
    environment: config.environment,
    apiBaseUrl: config.apiBaseUrl,
    supabaseUrl: config.supabaseUrl,
    supabaseAnonKey: config.supabaseAnonKey,
    geminiApiKey: config.geminiApiKey,
    sentryDsn: config.sentryDsn,
    enableLogging: config.enableLogging,
  );

  // Edge-to-Edge System UI
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const ProviderScope(child: MainApp()));
}
