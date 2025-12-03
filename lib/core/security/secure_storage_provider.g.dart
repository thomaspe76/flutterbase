// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flutterSecureStorage)
const flutterSecureStorageProvider = FlutterSecureStorageProvider._();

final class FlutterSecureStorageProvider extends $FunctionalProvider<
    FlutterSecureStorage,
    FlutterSecureStorage,
    FlutterSecureStorage> with $Provider<FlutterSecureStorage> {
  const FlutterSecureStorageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'flutterSecureStorageProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$flutterSecureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return flutterSecureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$flutterSecureStorageHash() =>
    r'c202f04c1bf96060b4f884cb7abc300362a2295d';

@ProviderFor(SecureStorageService)
const secureStorageServiceProvider = SecureStorageServiceProvider._();

final class SecureStorageServiceProvider
    extends $NotifierProvider<SecureStorageService, void> {
  const SecureStorageServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'secureStorageServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$secureStorageServiceHash();

  @$internal
  @override
  SecureStorageService create() => SecureStorageService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$secureStorageServiceHash() =>
    r'6a236db21837b6b515aff9fdfa057f031b053d4b';

abstract class _$SecureStorageService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleValue(ref, null);
  }
}
