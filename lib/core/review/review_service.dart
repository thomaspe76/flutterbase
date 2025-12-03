import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_service.g.dart';

@Riverpod(keepAlive: true)
ReviewService reviewService(Ref ref) {
  return ReviewService();
}

class ReviewService {
  final InAppReview _inAppReview = InAppReview.instance;

  Future<void> requestReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    }
  }

  Future<void> openStoreListing() async {
    await _inAppReview.openStoreListing();
  }
}
