enum Environment { dev, prod }

class EnvConfig {
  final Environment environment;
  final String apiBaseUrl;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final String geminiApiKey;
  final String sentryDsn;
  final bool enableLogging;

  const EnvConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.geminiApiKey,
    required this.sentryDsn,
    this.enableLogging = false,
  });

  static late EnvConfig _instance;
  static EnvConfig get instance => _instance;

  static void init({
    required Environment environment,
    required String apiBaseUrl,
    required String supabaseUrl,
    required String supabaseAnonKey,
    required String geminiApiKey,
    required String sentryDsn,
    bool enableLogging = false,
  }) {
    _instance = EnvConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
      geminiApiKey: geminiApiKey,
      sentryDsn: sentryDsn,
      enableLogging: enableLogging,
    );
  }
}
