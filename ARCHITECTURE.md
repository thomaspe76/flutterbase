# Architektur-Dokumentation

## Übersicht

FlutterBase implementiert **Clean Architecture** mit strikter Layer-Trennung und Dependency Inversion.

## Die drei Schichten

### 1. Domain Layer (Geschäftslogik)

**Zweck**: Enthält die Kern-Geschäftslogik der Anwendung, vollständig unabhängig von externen Frameworks.

**Komponenten**:

#### Entities
```dart
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  // ...
}
```
- Reine Dart-Klassen
- Repräsentieren Geschäftsobjekte
- Können Geschäftslogik enthalten (z.B. Validierung, Berechnungen)
- Keine Abhängigkeiten zu externen Packages (außer Dart core)

#### Repository Interfaces
```dart
abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();
}
```
- Definieren Kontrakte für Datenzugriff
- Keine Implementierungsdetails
- Ermöglichen Dependency Inversion

#### Use Cases
```dart
class GetCurrentUser implements UseCase<UserEntity, NoParams> {
  final UserRepository repository;

  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
```
- Eine Klasse = Eine Geschäftslogik
- Single Responsibility Principle
- Einfach zu testen
- Kapseln Anwendungsfälle

**Vorteile**:
- ✅ Unabhängig von UI-Framework
- ✅ Unabhängig von Datenquellen
- ✅ Einfach testbar
- ✅ Wiederverwendbar

---

### 2. Data Layer (Datenquellen)

**Zweck**: Verwaltet alle Daten-Operationen und implementiert die Repository-Interfaces.

**Komponenten**:

#### Models
```dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```
- Data Transfer Objects (DTOs)
- JSON Serialization/Deserialization
- Repräsentieren externe Daten (API, DB)
- Verwenden Freezed für Immutability

#### Data Sources
```dart
abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  Future<UserModel> getCurrentUser() async {
    final response = await dio.get('/users/me');
    return UserModel.fromJson(response.data);
  }
}
```
- **Remote**: API-Calls
- **Local**: Cache, Datenbank
- Fokussiert auf Datenquellen-spezifische Logik

#### Mappers
```dart
class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      name: model.name,
    );
  }
}
```
- Konvertierung zwischen Models und Entities
- Trennung von Daten-Repräsentation und Business-Logik
- Testbar und wiederverwendbar

#### Repository Implementations
```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final model = await remoteDataSource.getCurrentUser();
      await localDataSource.cacheUser(model);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```
- Koordiniert zwischen Data Sources
- Implementiert Caching-Strategie
- Error Handling
- Konvertiert Models zu Entities

**Vorteile**:
- ✅ Austauschbare Datenquellen
- ✅ Offline-First möglich
- ✅ Caching-Logik zentralisiert
- ✅ API-Änderungen isoliert

---

### 3. Presentation Layer (UI)

**Zweck**: Enthält UI und State Management, keine Business-Logik.

**Komponenten**:

#### State Classes
```dart
@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserEntity user) = _Loaded;
  const factory UserState.error(String message) = _Error;
}
```
- Sealed Union Types mit Freezed
- Typsichere State-Repräsentation
- Ermöglichen exhaustive when-Checks

#### Providers
```dart
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, UserState>((ref) {
  return CurrentUserNotifier(
    getCurrentUser: ref.watch(getCurrentUserUseCaseProvider),
  );
});

class CurrentUserNotifier extends StateNotifier<UserState> {
  final GetCurrentUser getCurrentUser;

  Future<void> loadCurrentUser() async {
    state = const UserState.loading();
    final result = await getCurrentUser(const NoParams());
    result.fold(
      (failure) => state = UserState.error(failure.message),
      (user) => state = UserState.loaded(user),
    );
  }
}
```
- Riverpod State Notifiers
- Rufen Use Cases auf
- Kein direkter Zugriff auf Repositories
- Emittieren State-Änderungen

#### Pages
```dart
class UserProfilePage extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final userState = ref.watch(currentUserProvider);

    return Scaffold(
      body: userState.when(
        loading: () => CircularProgressIndicator(),
        loaded: (user) => UserProfileView(user: user),
        error: (message) => ErrorView(message: message),
      ),
    );
  }
}
```
- ConsumerWidget/ConsumerStatefulWidget
- Beobachten Providers
- Reagieren auf State-Änderungen
- Keine Business-Logik

#### Widgets
```dart
class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String initials;

  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primary,
      child: Text(initials, style: AppTypography.h3),
    );
  }
}
```
- Kleine, fokussierte Widgets
- Single Responsibility
- Wiederverwendbar
- Verwenden Design System

**Vorteile**:
- ✅ Testbare UI-Logik
- ✅ Reaktive Updates
- ✅ Type-safe State
- ✅ Keine Business-Logik in UI

---

## Datenfluss

### Read Operation (User laden)
```
UserProfilePage
    ↓ (watch)
currentUserProvider.loadCurrentUser()
    ↓ (call)
GetCurrentUser Use Case
    ↓ (call)
UserRepository Interface
    ↓ (implements)
UserRepositoryImpl
    ↓ (fetch)
UserRemoteDataSource
    ↓ (HTTP)
API Server
    ↓ (response)
UserModel
    ↓ (map)
UserMapper.toEntity()
    ↓ (return)
UserEntity
    ↓ (emit)
UserState.loaded(user)
    ↓ (rebuild)
UserProfilePage (shows user)
```

### Write Operation (User aktualisieren)
```
UserProfilePage (user clicks save)
    ↓ (call)
currentUserProvider.updateUserProfile(user)
    ↓ (call)
UpdateUser Use Case
    ↓ (validate)
Business Logic (validation)
    ↓ (call)
UserRepository.updateUser()
    ↓ (map)
UserMapper.toModel()
    ↓ (send)
UserRemoteDataSource.updateUser()
    ↓ (HTTP PUT)
API Server
    ↓ (response)
UserModel
    ↓ (cache)
UserLocalDataSource.cacheUser()
    ↓ (map)
UserMapper.toEntity()
    ↓ (emit)
UserState.loaded(updatedUser)
    ↓ (rebuild)
UserProfilePage (shows updated user)
```

---

## Dependency Injection

### Setup (injection.dart)
```dart
// Core
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

// Data Sources
sl.registerLazySingleton<UserRemoteDataSource>(
  () => UserRemoteDataSourceImpl(),
);

// Repositories
sl.registerLazySingleton<UserRepository>(
  () => UserRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ),
);

// Use Cases
sl.registerLazySingleton(() => GetCurrentUser(sl()));
```

### Verwendung in Providern
```dart
final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  return sl<GetCurrentUser>();
});
```

**Vorteile**:
- ✅ Loose Coupling
- ✅ Einfaches Mocken für Tests
- ✅ Zentrale Dependency-Verwaltung
- ✅ Lazy Initialization

---

## Error Handling

### Failure-Klassen
```dart
abstract class Failure {
  final String message;
  final int? code;
}

class ServerFailure extends Failure { }
class NetworkFailure extends Failure { }
class CacheFailure extends Failure { }
class ValidationFailure extends Failure { }
```

### Either-Type
```dart
Future<Either<Failure, UserEntity>> getCurrentUser() async {
  try {
    final user = await remoteDataSource.getCurrentUser();
    return Right(UserMapper.toEntity(user));
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
```

### In UI
```dart
result.fold(
  (failure) => state = UserState.error(failure.message),
  (user) => state = UserState.loaded(user),
);
```

**Vorteile**:
- ✅ Type-safe Error Handling
- ✅ Forced Error Handling
- ✅ Unterschiedliche Failure-Typen
- ✅ Keine Exceptions in Business-Logik

---

## Testing-Strategie

### Unit Tests (Domain Layer)
```dart
test('should return user entity when call is successful', () async {
  // arrange
  when(mockRepository.getCurrentUser())
    .thenAnswer((_) async => Right(tUserEntity));

  // act
  final result = await useCase(NoParams());

  // assert
  expect(result, Right(tUserEntity));
  verify(mockRepository.getCurrentUser());
});
```

### Integration Tests (Data Layer)
```dart
test('should return user entity when remote call is successful', () async {
  // arrange
  when(mockRemoteDataSource.getCurrentUser())
    .thenAnswer((_) async => tUserModel);

  // act
  final result = await repository.getCurrentUser();

  // assert
  expect(result, Right(tUserEntity));
  verify(mockRemoteDataSource.getCurrentUser());
  verify(mockLocalDataSource.cacheUser(tUserModel));
});
```

### Widget Tests (Presentation Layer)
```dart
testWidgets('should show loading indicator when state is loading', (tester) async {
  // arrange
  when(mockNotifier.state).thenReturn(const UserState.loading());

  // act
  await tester.pumpWidget(makeTestableWidget());

  // assert
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

---

## Vorteile dieser Architektur

### 1. Testbarkeit
- Jede Schicht ist unabhängig testbar
- Einfaches Mocken durch Interfaces
- Hohe Test-Coverage möglich

### 2. Wartbarkeit
- Klare Struktur und Verantwortlichkeiten
- Änderungen isoliert in einer Schicht
- Einfaches Refactoring

### 3. Skalierbarkeit
- Neue Features folgen gleicher Struktur
- Team-Mitglieder wissen wo Code hingehört
- Parallele Entwicklung möglich

### 4. Flexibilität
- Austauschbare Datenquellen
- UI-Framework-unabhängige Business-Logik
- Einfache API-Migrationen

### 5. Wiederverwendbarkeit
- Use Cases in mehreren UIs verwendbar
- Entities platform-übergreifend nutzbar
- Gemeinsame Core-Logik

---

## Anti-Patterns vermeiden

### ❌ Don't: Business-Logik in UI
```dart
// BAD
class UserProfilePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final user = await http.get('api/users/me');  // ❌
    if (user.email.isEmpty) {  // ❌ Validation in UI
      return ErrorWidget();
    }
  }
}
```

### ✅ Do: Use Cases verwenden
```dart
// GOOD
class UserProfilePage extends ConsumerWidget {
  Widget build(BuildContext context) {
    final userState = ref.watch(currentUserProvider);
    return userState.when(
      loaded: (user) => UserProfileView(user: user),
      error: (message) => ErrorView(message: message),
    );
  }
}
```

### ❌ Don't: Hardcodierte Werte
```dart
// BAD
Text('Welcome', style: TextStyle(fontSize: 24))  // ❌
Container(color: Color(0xFF6366F1))  // ❌
SizedBox(height: 16)  // ❌
```

### ✅ Do: Design System verwenden
```dart
// GOOD
Text(l10n.welcome, style: AppTypography.h1)  // ✅
Container(color: AppColors.primary)  // ✅
SizedBox(height: AppSpacing.md)  // ✅
```

### ❌ Don't: Monolithische Klassen
```dart
// BAD
class UserManager {
  // 50+ Methoden
  Future<User> getUser() { }
  Future<void> updateUser() { }
  Future<void> deleteUser() { }
  Future<List<Post>> getUserPosts() { }
  Future<void> likePost() { }
  // ...
}
```

### ✅ Do: Single Responsibility
```dart
// GOOD
class GetCurrentUser implements UseCase<UserEntity, NoParams> { }
class UpdateUser implements UseCase<UserEntity, UpdateUserParams> { }
class DeleteUser implements UseCase<void, String> { }
class GetUserPosts implements UseCase<List<PostEntity>, String> { }
```

---

## Zusammenfassung

Diese Architektur bietet:
- ✅ Klare Separation of Concerns
- ✅ Dependency Inversion
- ✅ Single Responsibility
- ✅ Testbarkeit
- ✅ Wartbarkeit
- ✅ Skalierbarkeit

Befolgen Sie die Prinzipien konsequent für einen professionellen, wartbaren Codebase!
