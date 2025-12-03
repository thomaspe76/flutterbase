import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/auth_repository.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Stream<User?> build() {
    final repository = ref.watch(authRepositoryProvider);
    return repository.authStateChanges.map((event) => event.session?.user);
  }

  Future<void> signIn(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signInWithEmail(email, password);
  }

  Future<void> signUp(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signUpWithEmail(email, password);
  }

  Future<void> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
  }
}
