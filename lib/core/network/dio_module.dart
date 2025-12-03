import 'package:dio/dio.dart';

/// Centralized Dio configuration.
/// Provides a pre-configured Dio instance for the entire app.
class DioModule {
  static Dio provideDio() {
    final dio = Dio();

    // Default configurations
    // Base URL should be set via EnvConfig in a real app
    // dio.options.baseUrl = EnvConfig.apiUrl;

    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add interceptors here
    // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
