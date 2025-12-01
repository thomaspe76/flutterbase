import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for getting the current authenticated user.
/// Each use case has a single responsibility and contains business logic.
class GetCurrentUser implements UseCase<UserEntity, NoParams> {
  final UserRepository repository;

  const GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
