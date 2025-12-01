import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_state.freezed.dart';

/// State for user-related UI.
/// Uses Freezed to create a sealed union type for different states.
@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserEntity user) = _Loaded;
  const factory UserState.error(String message) = _Error;
}
