import '../models/user_model.dart';

/// Remote data source for user data.
/// This handles all HTTP requests related to users.
/// In a real app, this would use Dio/Retrofit for API calls.
abstract class UserRemoteDataSource {
  /// Fetch user by ID from API
  Future<UserModel> getUserById(String id);

  /// Fetch current user from API
  Future<UserModel> getCurrentUser();

  /// Update user on API
  Future<UserModel> updateUser(UserModel user);

  /// Delete user on API
  Future<void> deleteUser(String id);

  /// Fetch all users from API
  Future<List<UserModel>> getAllUsers();
}

/// Implementation of remote data source
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  // In a real app, inject Dio client here
  // final Dio dio;
  // const UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> getUserById(String id) async {
    // Simulate API call
    // In real implementation:
    // final response = await dio.get('/users/$id');
    // return UserModel.fromJson(response.data);

    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(
      id: id,
      email: 'user@example.com',
      name: 'John Doe',
      avatarUrl: null,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(
      id: '1',
      email: 'current@example.com',
      name: 'Current User',
      avatarUrl: null,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    // Simulate API call
    // In real implementation:
    // final response = await dio.put('/users/${user.id}', data: user.toJson());
    // return UserModel.fromJson(response.data);

    await Future.delayed(const Duration(milliseconds: 500));
    return user;
  }

  @override
  Future<void> deleteUser(String id) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      UserModel(
        id: '1',
        email: 'user1@example.com',
        name: 'Alice Johnson',
        avatarUrl: null,
        createdAt: DateTime.now(),
      ),
      UserModel(
        id: '2',
        email: 'user2@example.com',
        name: 'Bob Smith',
        avatarUrl: null,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
