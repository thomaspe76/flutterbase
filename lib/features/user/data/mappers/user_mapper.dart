import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

/// Mapper class to convert between UserModel and UserEntity.
/// This keeps the conversion logic separate and testable.
class UserMapper {
  UserMapper._();

  /// Convert model to entity
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      name: model.name,
      avatarUrl: model.avatarUrl,
      createdAt: model.createdAt,
    );
  }

  /// Convert entity to model
  static UserModel toModel(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      avatarUrl: entity.avatarUrl,
      createdAt: entity.createdAt,
    );
  }

  /// Convert list of models to entities
  static List<UserEntity> toEntityList(List<UserModel> models) {
    return models.map(toEntity).toList();
  }

  /// Convert list of entities to models
  static List<UserModel> toModelList(List<UserEntity> entities) {
    return entities.map(toModel).toList();
  }
}
