import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for updating a user.
/// Demonstrates how to pass parameters to a use case.
class UpdateUser implements UseCase<UserEntity, UpdateUserParams> {
  final UserRepository repository;

  const UpdateUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateUserParams params) async {
    // Add business logic/validation here if needed
    if (params.user.email.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Email cannot be empty'),
      );
    }

    return await repository.updateUser(params.user);
  }
}

/// Parameters for UpdateUser use case
class UpdateUserParams extends Equatable {
  final UserEntity user;

  const UpdateUserParams({required this.user});

  @override
  List<Object?> get props => [user];
}
