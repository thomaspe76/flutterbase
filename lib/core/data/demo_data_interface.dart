/// Interface for managing demo data.
/// Useful for testing, screenshots, and app store reviews.
abstract class DemoDataInterface {
  /// Whether demo mode is currently active.
  bool get isDemoMode;

  /// Enable or disable demo mode.
  Future<void> setDemoMode(bool enabled);

  /// Populate the database with demo data.
  Future<void> seedDemoData();

  /// Clear all demo data.
  Future<void> clearDemoData();
}
