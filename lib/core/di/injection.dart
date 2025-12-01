import 'package:get_it/get_it.dart';
import '../../features/user/data/datasources/user_local_datasource.dart';
import '../../features/user/data/datasources/user_remote_datasource.dart';
import '../../features/user/data/repositories/user_repository_impl.dart';
import '../../features/user/domain/repositories/user_repository.dart';
import '../../features/user/domain/usecases/get_current_user.dart';
import '../../features/user/domain/usecases/update_user.dart';
import '../network/network_info.dart';

/// Service locator for dependency injection.
/// Using GetIt for simple and effective dependency management.
final sl = GetIt.instance;

/// Initialize all dependencies.
/// Call this in main() before running the app.
Future<void> initializeDependencies() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // User Feature
  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
}
