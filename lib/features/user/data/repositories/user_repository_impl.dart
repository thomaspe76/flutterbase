import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../mappers/user_mapper.dart';

/// Implementation of UserRepository.
/// This coordinates between remote and local data sources,
/// handles errors, and converts models to entities.
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    try {
      if (await networkInfo.isConnected) {
        // Fetch from remote
        final userModel = await remoteDataSource.getUserById(id);
        // Cache it
        await localDataSource.cacheUser(userModel);
        // Convert to entity and return
        return Right(UserMapper.toEntity(userModel));
      } else {
        // Try to get from cache
        final cachedUser = await localDataSource.getCachedUser(id);
        if (cachedUser != null) {
          return Right(UserMapper.toEntity(cachedUser));
        } else {
          return const Left(
            NetworkFailure(message: 'No internet connection and no cached data'),
          );
        }
      }
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      await localDataSource.cacheUser(userModel);
      return Right(UserMapper.toEntity(userModel));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      // Convert entity to model
      final userModel = await remoteDataSource.updateUser(
        UserMapper.toModel(user),
      );

      // Cache updated user
      await localDataSource.cacheUser(userModel);

      return Right(UserMapper.toEntity(userModel));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      await remoteDataSource.deleteUser(id);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await remoteDataSource.getAllUsers();
      return Right(UserMapper.toEntityList(users));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
