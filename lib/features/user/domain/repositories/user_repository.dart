import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Repository interface for user-related operations.
/// This is defined in the domain layer as an abstraction.
/// The actual implementation is in the data layer, following Dependency Inversion Principle.
abstract class UserRepository {
  /// Get user by ID
  Future<Either<Failure, UserEntity>> getUserById(String id);

  /// Get current authenticated user
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Update user profile
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user);

  /// Delete user
  Future<Either<Failure, void>> deleteUser(String id);

  /// Get all users (for admin features)
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
}
