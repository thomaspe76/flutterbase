import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';
import '../security/secure_local_storage.dart';

part 'supabase_provider.g.dart';

@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

@Riverpod(keepAlive: true)
Future<void> initializeSupabase(Ref ref) async {
  await Supabase.initialize(
    url: EnvConfig.instance.supabaseUrl,
    anonKey: EnvConfig.instance.supabaseAnonKey,
    authOptions: FlutterAuthClientOptions(
      localStorage: SecureLocalStorage(),
    ),
  );
}
