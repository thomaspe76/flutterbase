/// Interface for managing user consent (GDPR/DSGVO).
/// Ensures "Privacy by Design" by requiring explicit checks before tracking.
abstract class ConsentService {
  /// Whether the user has granted consent for analytics/tracking.
  Future<bool> get hasAnalyticsConsent;

  /// Whether the user has granted consent for crash reporting.
  Future<bool> get hasCrashlyticsConsent;

  /// Request consent from the user.
  /// Returns true if consent was granted.
  Future<bool> requestConsent();

  /// Update consent status.
  Future<void> updateConsent({
    required bool analytics,
    required bool crashlytics,
  });
}
