import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Zentraler Service für Hive-Initialisierung und Box-Management.
///
/// Verwendung:
/// 1. In main.dart: await HiveService.initialize();
/// 2. Adapter registrieren: HiveService.registerAdapters([MyAdapter()]);
/// 3. Box öffnen: `await HiveService.openBox<MyModel>('myBox')`
class HiveService {
  static const String settingsBox = 'settings';
  static const String cacheBox = 'cache';

  static bool _initialized = false;
  static final List<TypeAdapter> _pendingAdapters = [];

  /// Initializes Hive with the given `subDir`.
  ///
  /// If `subDir` is not provided, it defaults to 'hive_db'.
  /// Returns a `Future<void>` when initialization is complete.
  static Future<void> initialize() async {
    if (_initialized) return;

    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter('${appDocDir.path}/hive');

    // Pending Adapter registrieren
    for (final adapter in _pendingAdapters) {
      if (!Hive.isAdapterRegistered(adapter.typeId)) {
        Hive.registerAdapter(adapter);
      }
    }
    _pendingAdapters.clear();

    // Standard-Boxen öffnen
    await Hive.openBox(settingsBox);
    await Hive.openBox(cacheBox);

    _initialized = true;
  }

  /// Registriert Hive-Adapter (vor oder nach initialize() aufrufbar)
  static void registerAdapters(List<TypeAdapter> adapters) {
    for (final adapter in adapters) {
      if (_initialized) {
        if (!Hive.isAdapterRegistered(adapter.typeId)) {
          Hive.registerAdapter(adapter);
        }
      } else {
        _pendingAdapters.add(adapter);
      }
    }
  }

  /// Öffnet eine typisierte Box
  static Future<Box<T>> openBox<T>(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box<T>(name);
    }
    return await Hive.openBox<T>(name);
  }

  /// Holt eine bereits geöffnete Box
  static Box<T> getBox<T>(String name) {
    return Hive.box<T>(name);
  }

  /// Settings-Box Shortcut
  static Box get settings => Hive.box(settingsBox);

  /// Schließt alle Boxen
  static Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }

  /// Löscht alle Daten (für Logout/Reset)
  static Future<void> clearAll() async {
    final boxes = ['settings', 'cache']; // Erweitern nach Bedarf
    for (final boxName in boxes) {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).clear();
      }
    }
  }
}
