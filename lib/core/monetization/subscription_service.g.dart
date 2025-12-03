// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionService)
const subscriptionServiceProvider = SubscriptionServiceProvider._();

final class SubscriptionServiceProvider
    extends $AsyncNotifierProvider<SubscriptionService, bool> {
  const SubscriptionServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionServiceHash();

  @$internal
  @override
  SubscriptionService create() => SubscriptionService();
}

String _$subscriptionServiceHash() =>
    r'66b7b630e69846faa922067aa447c741ebc8a360';

abstract class _$SubscriptionService extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
