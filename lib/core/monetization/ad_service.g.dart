// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdService)
const adServiceProvider = AdServiceProvider._();

final class AdServiceProvider extends $AsyncNotifierProvider<AdService, void> {
  const AdServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adServiceHash();

  @$internal
  @override
  AdService create() => AdService();
}

String _$adServiceHash() => r'86d5c4d08c3ff37a08d5d50b8134f694f9aaf029';

abstract class _$AdService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleValue(ref, null);
  }
}

@ProviderFor(shouldShowAds)
const shouldShowAdsProvider = ShouldShowAdsProvider._();

final class ShouldShowAdsProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const ShouldShowAdsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'shouldShowAdsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$shouldShowAdsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return shouldShowAds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$shouldShowAdsHash() => r'df60782cc4f9c50a4907c2f8302dfb9667e1f1e9';
