// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reviewService)
const reviewServiceProvider = ReviewServiceProvider._();

final class ReviewServiceProvider
    extends $FunctionalProvider<ReviewService, ReviewService, ReviewService>
    with $Provider<ReviewService> {
  const ReviewServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'reviewServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$reviewServiceHash();

  @$internal
  @override
  $ProviderElement<ReviewService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReviewService create(Ref ref) {
    return reviewService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewService>(value),
    );
  }
}

String _$reviewServiceHash() => r'bd3aee06a85b3fafe01d731d5e444e517743c8e4';
