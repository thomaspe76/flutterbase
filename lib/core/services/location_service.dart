/// Interface for location services.
/// Allows for easy mocking and swapping of location providers (e.g. Geolocator).
abstract class LocationService {
  /// Checks if location permissions are granted.
  Future<bool> checkPermissions();

  /// Request location permissions.
  Future<bool> requestPermissions();

  /// Gets the current city name.
  /// Throws an exception if location is unavailable or permission denied.
  Future<String?> getCurrentCity();
}
