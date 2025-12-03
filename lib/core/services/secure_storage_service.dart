import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for securely storing sensitive data (e.g. tokens, PII).
/// Wraps [FlutterSecureStorage] to provide a clean interface and potential for future abstraction.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  /// Reads a value from secure storage.
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Writes a value to secure storage.
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// Deletes a value from secure storage.
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Deletes all values from secure storage.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
