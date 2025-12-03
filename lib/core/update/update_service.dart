import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../network/supabase_provider.dart';

part 'update_service.g.dart';

@Riverpod(keepAlive: true)
UpdateService updateService(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return UpdateService(supabase);
}

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}

class UpdateService {
  final SupabaseClient _supabaseClient;

  UpdateService(this._supabaseClient);

  Future<bool> isUpdateRequired() async {
    try {
      // 1. Get current app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      // 2. Get min supported version from Supabase (Remote Config)
      // Assuming a table 'app_config' with a row 'min_supported_version'
      final response = await _supabaseClient
          .from('app_config')
          .select('value')
          .eq('key', 'min_supported_version')
          .maybeSingle();

      if (response == null) return false;

      final minVersion = response['value'] as String;

      // 3. Compare versions
      return _isVersionLower(currentVersion, minVersion);
    } catch (e) {
      // Fail safe: if check fails, don't block user
      return false;
    }
  }

  bool _isVersionLower(String current, String min) {
    // Simple semantic version comparison logic
    // This is a simplified implementation. For production, use `pub_semver` package.
    return current.compareTo(min) < 0;
  }
}
