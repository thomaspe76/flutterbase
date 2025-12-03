import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'consent_manager.g.dart';

enum ConsentType {
  analytics,
  marketing,
  crashReporting,
}

@riverpod
class ConsentManager extends _$ConsentManager {
  static const _prefix = 'consent_';

  @override
  Future<Map<ConsentType, bool>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final state = <ConsentType, bool>{};

    for (final type in ConsentType.values) {
      state[type] = prefs.getBool('$_prefix${type.name}') ?? false;
    }

    return state;
  }

  Future<void> setConsent(ConsentType type, bool granted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefix${type.name}', granted);

    final newState = Map<ConsentType, bool>.from(state.value ?? {});
    newState[type] = granted;
    state = AsyncValue.data(newState);
  }

  Future<void> grantAll() async {
    final prefs = await SharedPreferences.getInstance();
    final newState = <ConsentType, bool>{};

    for (final type in ConsentType.values) {
      await prefs.setBool('$_prefix${type.name}', true);
      newState[type] = true;
    }
    state = AsyncValue.data(newState);
  }

  Future<void> revokeAll() async {
    final prefs = await SharedPreferences.getInstance();
    final newState = <ConsentType, bool>{};

    for (final type in ConsentType.values) {
      await prefs.setBool('$_prefix${type.name}', false);
      newState[type] = false;
    }
    state = AsyncValue.data(newState);
  }
}
