// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flutterSecureStorageHash() =>
    r'c202f04c1bf96060b4f884cb7abc300362a2295d';

/// See also [flutterSecureStorage].
@ProviderFor(flutterSecureStorage)
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>.internal(
  flutterSecureStorage,
  name: r'flutterSecureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flutterSecureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlutterSecureStorageRef = ProviderRef<FlutterSecureStorage>;
String _$secureStorageServiceHash() =>
    r'6a236db21837b6b515aff9fdfa057f031b053d4b';

/// See also [SecureStorageService].
@ProviderFor(SecureStorageService)
final secureStorageServiceProvider =
    AutoDisposeNotifierProvider<SecureStorageService, void>.internal(
  SecureStorageService.new,
  name: r'secureStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SecureStorageService = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
