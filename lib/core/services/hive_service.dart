import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Zentraler Service für Hive Local Storage.
///
/// HINWEIS: hive_generator ist nicht kompatibel mit freezed 3.x
/// TypeAdapter müssen manuell implementiert werden.
///
/// Beispiel für manuellen TypeAdapter:
/// ```dart
/// class UserModelAdapter extends TypeAdapter<UserModel> {
///   @override
///   final int typeId = 0; // Eindeutige ID pro Model
///
///   @override
///   UserModel read(BinaryReader reader) {
///     return UserModel(
///       id: reader.readString(),
///       name: reader.readString(),
///     );
///   }
///
///   @override
///   void write(BinaryWriter writer, UserModel obj) {
///     writer.writeString(obj.id);
///     writer.writeString(obj.name);
///   }
/// }
/// ```
class HiveService {
  static const String settingsBox = 'settings';
  static const String cacheBox = 'cache';

  static bool _initialized = false;
  static final List<TypeAdapter<dynamic>> _pendingAdapters = [];

  /// Initialisiert Hive
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter('${appDocDir.path}/hive_data');

      // Registriere wartende Adapter
      for (final adapter in _pendingAdapters) {
        if (!Hive.isAdapterRegistered(adapter.typeId)) {
          Hive.registerAdapter(adapter);
        }
      }
      _pendingAdapters.clear();

      // Standard-Boxen öffnen
      await Hive.openBox<dynamic>(settingsBox);
      await Hive.openBox<dynamic>(cacheBox);

      _initialized = true;
      debugPrint('[HiveService] Initialized');
    } catch (e) {
      debugPrint('[HiveService] Init failed: $e');
      rethrow;
    }
  }

  /// Registriert TypeAdapter (vor oder nach initialize aufrufbar)
  static void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (_initialized) {
      if (!Hive.isAdapterRegistered(adapter.typeId)) {
        Hive.registerAdapter(adapter);
      }
    } else {
      _pendingAdapters.add(adapter);
    }
  }

  /// Registriert mehrere Adapter
  static void registerAdapters(List<TypeAdapter<dynamic>> adapters) {
    for (final adapter in adapters) {
      registerAdapter(adapter);
    }
  }

  /// Öffnet eine typisierte Box
  static Future<Box<T>> openBox<T>(String name) async {
    if (!_initialized) {
      throw StateError('HiveService not initialized. Call initialize() first.');
    }
    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    }
    return Hive.openBox<T>(name);
  }

  /// Holt eine bereits geöffnete Box
  static Box<T> box<T>(String name) => Hive.box<T>(name);

  /// Settings-Box Shortcut
  static Box<dynamic> get settings => Hive.box<dynamic>(settingsBox);

  /// Cache-Box Shortcut
  static Box<dynamic> get cache => Hive.box<dynamic>(cacheBox);

  // === SETTINGS HELPER ===

  static T? getSetting<T>(String key, {T? defaultValue}) {
    return settings.get(key, defaultValue: defaultValue) as T?;
  }

  static Future<void> setSetting<T>(String key, T value) async {
    await settings.put(key, value);
  }

  static Future<void> removeSetting(String key) async {
    await settings.delete(key);
  }

  // === LIFECYCLE ===

  /// Schließt alle Boxen
  static Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }

  /// Löscht alle Daten
  static Future<void> clearAll() async {
    await settings.clear();
    await cache.clear();
  }

  /// Löscht Hive komplett vom Dateisystem
  static Future<void> deleteFromDisk() async {
    await Hive.deleteFromDisk();
    _initialized = false;
  }
}
