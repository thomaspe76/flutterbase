import 'package:equatable/equatable.dart';

/// User entity - represents a user in the business logic layer.
/// This is a pure Dart class with no dependencies on external packages.
/// It focuses solely on business logic, not data representation.
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, email, name, avatarUrl, createdAt];

  /// Get user initials for avatar placeholder
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }

  /// Check if user has a complete profile
  bool get hasCompleteProfile {
    return name.isNotEmpty && email.isNotEmpty;
  }
}
