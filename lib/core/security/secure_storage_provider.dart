import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      resetOnError: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
}

@riverpod
class SecureStorageService extends _$SecureStorageService {
  @override
  void build() {}

  Future<void> write({required String key, required String value}) async {
    final storage = ref.read(flutterSecureStorageProvider);
    await storage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    final storage = ref.read(flutterSecureStorageProvider);
    return await storage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    final storage = ref.read(flutterSecureStorageProvider);
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    final storage = ref.read(flutterSecureStorageProvider);
    await storage.deleteAll();
  }
}
