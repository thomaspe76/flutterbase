import '../models/user_model.dart';

/// Local data source for user data.
/// This handles local caching using SharedPreferences, Hive, etc.
abstract class UserLocalDataSource {
  /// Cache user data locally
  Future<void> cacheUser(UserModel user);

  /// Get cached user
  Future<UserModel?> getCachedUser(String id);

  /// Clear cached user
  Future<void> clearCache();
}

/// Implementation of local data source
class UserLocalDataSourceImpl implements UserLocalDataSource {
  // In a real app, inject SharedPreferences or Hive here
  // final SharedPreferences sharedPreferences;
  // const UserLocalDataSourceImpl(this.sharedPreferences);

  final Map<String, UserModel> _cache = {};

  @override
  Future<void> cacheUser(UserModel user) async {
    // In real implementation:
    // await sharedPreferences.setString('user_${user.id}', jsonEncode(user.toJson()));

    _cache[user.id] = user;
  }

  @override
  Future<UserModel?> getCachedUser(String id) async {
    // In real implementation:
    // final jsonString = sharedPreferences.getString('user_$id');
    // if (jsonString != null) {
    //   return UserModel.fromJson(jsonDecode(jsonString));
    // }
    // return null;

    return _cache[id];
  }

  @override
  Future<void> clearCache() async {
    // In real implementation:
    // Clear all user-related keys from SharedPreferences

    _cache.clear();
  }
}
