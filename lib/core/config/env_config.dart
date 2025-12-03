import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized access to environment variables.
/// Loads variables from .env file.
class EnvConfig {
  /// Base URL for API requests.
  static String get apiUrl => dotenv.env['API_URL'] ?? '';

  /// API Key for external services.
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  // Add other environment variables here
}
