import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Connection timed out');
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final data = exception.response?.data;
        return ApiException(
          message: data?['message'] ?? 'Server error occurred',
          statusCode: statusCode,
          data: data,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection');
      default:
        return ApiException(message: 'Something went wrong');
    }
  }

  @override
  String toString() =>
      'ApiException(message: $message, statusCode: $statusCode)';
}
