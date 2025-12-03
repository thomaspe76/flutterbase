// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConsentManager)
const consentManagerProvider = ConsentManagerProvider._();

final class ConsentManagerProvider
    extends $AsyncNotifierProvider<ConsentManager, Map<ConsentType, bool>> {
  const ConsentManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'consentManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$consentManagerHash();

  @$internal
  @override
  ConsentManager create() => ConsentManager();
}

String _$consentManagerHash() => r'3a45721ca992ccca1ad7bc84eb72ae2d3c6ca118';

abstract class _$ConsentManager extends $AsyncNotifier<Map<ConsentType, bool>> {
  FutureOr<Map<ConsentType, bool>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref
        as $Ref<AsyncValue<Map<ConsentType, bool>>, Map<ConsentType, bool>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Map<ConsentType, bool>>, Map<ConsentType, bool>>,
        AsyncValue<Map<ConsentType, bool>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
