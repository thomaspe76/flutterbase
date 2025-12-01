# FlutterBase - Professional Flutter Architecture

Eine professionell strukturierte Flutter-Anwendung mit Clean Architecture, vollständiger Separation of Concerns und Best Practices.

## 🏗️ Architektur

Dieses Projekt folgt **Clean Architecture** Prinzipien mit klarer Trennung in drei Hauptschichten:

```
lib/
├── core/                          # Kern-Funktionalität für die gesamte App
│   ├── design_system/             # Zentralisiertes Design System
│   │   ├── app_colors.dart        # Alle Farbdefinitionen
│   │   ├── app_spacing.dart       # Alle Abstände und Radien
│   │   ├── app_typography.dart    # Alle Textsstile
│   │   └── app_theme.dart         # Theme-Konfiguration
│   ├── di/                        # Dependency Injection
│   │   └── injection.dart         # Service Locator Setup
│   ├── error/                     # Error Handling
│   │   └── failures.dart          # Failure-Klassen
│   ├── network/                   # Netzwerk-Infrastruktur
│   │   └── network_info.dart      # Netzwerkstatus-Prüfung
│   └── usecase/                   # Base UseCase
│       └── usecase.dart           # UseCase Interface
│
├── features/                      # Feature-Module
│   └── user/                      # User-Feature (Beispiel)
│       ├── domain/                # Domain Layer (Business Logic)
│       │   ├── entities/          # Business-Objekte
│       │   │   └── user_entity.dart
│       │   ├── repositories/      # Repository-Interfaces
│       │   │   └── user_repository.dart
│       │   └── usecases/          # Use Cases (Business Logic)
│       │       ├── get_current_user.dart
│       │       └── update_user.dart
│       │
│       ├── data/                  # Data Layer (Datenquellen)
│       │   ├── models/            # Data Transfer Objects
│       │   │   └── user_model.dart
│       │   ├── datasources/       # Datenquellen
│       │   │   ├── user_remote_datasource.dart
│       │   │   └── user_local_datasource.dart
│       │   ├── mappers/           # Model <-> Entity Konvertierung
│       │   │   └── user_mapper.dart
│       │   └── repositories/      # Repository-Implementierungen
│       │       └── user_repository_impl.dart
│       │
│       └── presentation/          # Presentation Layer (UI)
│           ├── pages/             # Seiten/Screens
│           │   └── user_profile_page.dart
│           ├── widgets/           # Wiederverwendbare Widgets
│           │   ├── user_avatar.dart
│           │   └── user_info_card.dart
│           ├── providers/         # Riverpod Providers
│           │   └── user_providers.dart
│           └── state/             # State-Klassen
│               └── user_state.dart
│
├── l10n/                          # Lokalisierung
│   ├── app_de.arb                 # Deutsche Strings
│   └── app_en.arb                 # Englische Strings
│
└── main.dart                      # App-Einstiegspunkt
```

## 🎯 Architektur-Prinzipien

### 1. **Separation of Concerns**
Jede Schicht hat eine klare Verantwortung:

- **Domain Layer**: Enthält die Geschäftslogik und ist unabhängig von externen Frameworks
- **Data Layer**: Verwaltet Datenquellen (API, Datenbank, Cache)
- **Presentation Layer**: Enthält UI und State Management

### 2. **Dependency Inversion**
- Höhere Schichten hängen nicht von niedrigeren ab
- Repositories sind als Interfaces im Domain Layer definiert
- Implementierungen sind im Data Layer

### 3. **Single Responsibility Principle**
- Jede Klasse hat eine einzige, klar definierte Aufgabe
- Use Cases enthalten jeweils nur eine Geschäftslogik
- Widgets haben nur UI-Verantwortung

### 4. **Keine monolithischen Models**
- **Entities** für Business-Logik (Domain Layer)
- **Models** für Daten-Transfer (Data Layer)
- **Mapper** für Konvertierung zwischen beiden

## 🎨 Design System

### Farben (`app_colors.dart`)
Alle Farben sind zentral definiert. **Niemals** hardcodierte Farben im Code verwenden!

```dart
// ✅ Richtig
Container(color: AppColors.primary)

// ❌ Falsch
Container(color: Color(0xFF6366F1))
Container(color: Colors.blue)
```

### Abstände (`app_spacing.dart`)
Alle Abstände folgen einem 4px-Grid-System.

```dart
// ✅ Richtig
SizedBox(height: AppSpacing.md)
Padding(padding: EdgeInsets.all(AppSpacing.cardPadding))

// ❌ Falsch
SizedBox(height: 16)
Padding(padding: EdgeInsets.all(12))
```

### Typographie (`app_typography.dart`)
Alle Textstile sind vordefiniert.

```dart
// ✅ Richtig
Text('Titel', style: AppTypography.h1)

// ❌ Falsch
Text('Titel', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
```

## 🌍 Lokalisierung

Alle UI-Strings sind in `.arb`-Dateien ausgelagert. **Niemals** hardcodierte Strings im Code!

```dart
// ✅ Richtig
Text(l10n.welcome)

// ❌ Falsch
Text('Willkommen')
```

### Neue Strings hinzufügen

1. String in `lib/l10n/app_de.arb` hinzufügen:
```json
{
  "myNewString": "Mein neuer Text",
  "@myNewString": {
    "description": "Beschreibung des Strings"
  }
}
```

2. In `lib/l10n/app_en.arb` übersetzen
3. Code generieren: `flutter gen-l10n`
4. Im Code verwenden: `l10n.myNewString`

## 🔧 Dependency Injection

Wir verwenden **GetIt** für Service Location:

```dart
// Registrierung in lib/core/di/injection.dart
sl.registerLazySingleton<UserRepository>(
  () => UserRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ),
);

// Verwendung in Providers
final repository = sl<UserRepository>();
```

## 📦 State Management

Wir verwenden **Riverpod** für State Management:

```dart
// Provider definieren
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, UserState>((ref) {
  return CurrentUserNotifier(
    getCurrentUser: ref.watch(getCurrentUserUseCaseProvider),
  );
});

// Im Widget verwenden
final userState = ref.watch(currentUserProvider);
```

## 🚀 Code-Generierung

Das Projekt verwendet Code-Generierung für:
- **Freezed**: Immutable Models und State-Klassen
- **JSON Serialization**: API-Response-Parsing
- **Riverpod**: Provider-Generierung (optional)

Code generieren:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch-Mode (automatische Generierung):
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 📋 Best Practices

### ✅ Do's
- Verwende immer das Design System
- Lagere alle Strings in .arb aus
- Halte Use Cases klein und fokussiert
- Trenne Models (Data) und Entities (Domain)
- Schreibe Widgets mit Single Responsibility
- Verwende const Constructors wo möglich

### ❌ Don'ts
- Keine hardcodierten Farben, Abstände oder Schriftgrößen
- Keine hardcodierten Strings
- Keine Business-Logik in Widgets
- Keine direkten API-Calls in UI
- Keine monolithischen Klassen
- Keine Cross-Layer Dependencies

## 🧪 Testing

Die Architektur ermöglicht einfaches Testen:

```dart
// Domain Layer (Use Cases) - Pure Dart, einfach zu testen
test('should get current user', () async {
  final result = await useCase(NoParams());
  expect(result.isRight(), true);
});

// Repository - Mock Data Sources
test('should return user from remote', () async {
  when(mockRemoteDataSource.getCurrentUser())
    .thenAnswer((_) async => mockUserModel);

  final result = await repository.getCurrentUser();
  expect(result.isRight(), true);
});

// Presentation - Mock Providers
testWidgets('should show user profile', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserProvider.overrideWith((_) => mockNotifier),
      ],
      child: UserProfilePage(),
    ),
  );
});
```

## 📚 Weitere Ressourcen

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Riverpod Documentation](https://riverpod.dev/)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [GetIt Documentation](https://pub.dev/packages/get_it)

## 🔄 Migration bestehender Features

Wenn Sie ein bestehendes Feature refactoren:

1. **Entities erstellen** (Domain Layer)
2. **Repository Interface definieren** (Domain Layer)
3. **Use Cases erstellen** (Domain Layer)
4. **Models erstellen** (Data Layer)
5. **Data Sources implementieren** (Data Layer)
6. **Repository implementieren** (Data Layer)
7. **Mapper erstellen** (Data Layer)
8. **State-Klassen erstellen** (Presentation Layer)
9. **Providers erstellen** (Presentation Layer)
10. **UI refactoren** (Presentation Layer)

## 📝 Code-Review Checkliste

Bei jedem Pull Request prüfen:

- [ ] Keine hardcodierten Farben/Abstände/Fonts
- [ ] Keine hardcodierten Strings (alle in .arb)
- [ ] Klare Layer-Trennung eingehalten
- [ ] Use Cases haben Single Responsibility
- [ ] Models und Entities sind getrennt
- [ ] Dependency Injection korrekt verwendet
- [ ] Const Constructors wo möglich
- [ ] Keine Business-Logik in UI
- [ ] Dokumentation/Kommentare wo nötig

---

**Viel Erfolg mit sauberem, wartbarem Code! 🚀**
