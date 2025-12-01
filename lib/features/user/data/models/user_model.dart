import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model - represents data from external sources (API, database).
/// This is separate from the entity to maintain separation between
/// data representation and business logic.
/// Uses Freezed for immutability and JSON serialization.
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? avatarUrl,
    required DateTime createdAt,
  }) = _UserModel;

  /// JSON deserialization
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
