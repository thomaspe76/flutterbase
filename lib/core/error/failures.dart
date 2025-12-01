import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
/// Each layer can define specific failure types.
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Authentication-related failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.code,
  });
}

/// Authorization-related failures
class AuthorizationFailure extends Failure {
  const AuthorizationFailure({
    required super.message,
    super.code,
  });
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code,
  });
}
