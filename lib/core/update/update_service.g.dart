// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateService)
const updateServiceProvider = UpdateServiceProvider._();

final class UpdateServiceProvider
    extends $FunctionalProvider<UpdateService, UpdateService, UpdateService>
    with $Provider<UpdateService> {
  const UpdateServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateServiceHash();

  @$internal
  @override
  $ProviderElement<UpdateService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateService create(Ref ref) {
    return updateService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateService>(value),
    );
  }
}

String _$updateServiceHash() => r'e4872e0a1e154840612a1a44460d65bd76af4895';

@ProviderFor(packageInfo)
const packageInfoProvider = PackageInfoProvider._();

final class PackageInfoProvider extends $FunctionalProvider<
        AsyncValue<PackageInfo>, PackageInfo, FutureOr<PackageInfo>>
    with $FutureModifier<PackageInfo>, $FutureProvider<PackageInfo> {
  const PackageInfoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'packageInfoProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$packageInfoHash();

  @$internal
  @override
  $FutureProviderElement<PackageInfo> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PackageInfo> create(Ref ref) {
    return packageInfo(ref);
  }
}

String _$packageInfoHash() => r'44d37547139567a5f03c1942c1d62ff1abb07248';
