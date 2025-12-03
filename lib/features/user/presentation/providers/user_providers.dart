import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/update_user.dart';
import '../state/user_state.dart';

/// Provider for GetCurrentUser use case
final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return sl<GetCurrentUser>();
});

/// Provider for UpdateUser use case
final updateUserUseCaseProvider = Provider<UpdateUser>((ref) {
  return sl<UpdateUser>();
});

/// Provider for current user state
final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, UserState>((ref) {
  return CurrentUserNotifier(
    getCurrentUser: ref.watch(getCurrentUserUseCaseProvider),
    updateUser: ref.watch(updateUserUseCaseProvider),
  );
});

/// State notifier for managing current user
class CurrentUserNotifier extends StateNotifier<UserState> {
  final GetCurrentUser getCurrentUser;
  final UpdateUser updateUser;

  CurrentUserNotifier({
    required this.getCurrentUser,
    required this.updateUser,
  }) : super(const UserState.initial());

  /// Load current user
  Future<void> loadCurrentUser() async {
    state = const UserState.loading();

    final result = await getCurrentUser(const NoParams());

    result.fold(
      (failure) => state = UserState.error(failure.message),
      (user) => state = UserState.loaded(user),
    );
  }

  /// Update user profile
  Future<void> updateUserProfile(UserEntity user) async {
    state = const UserState.loading();

    final result = await updateUser(UpdateUserParams(user: user));

    result.fold(
      (failure) => state = UserState.error(failure.message),
      (user) => state = UserState.loaded(user),
    );
  }
}
