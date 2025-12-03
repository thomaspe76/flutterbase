import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool notificationsEnabled,
    @Default(15.0) double notificationLeadTime,
    @Default(false) bool cloudBackupEnabled,
    @Default(true) bool hapticsEnabled,
    @Default(true) bool animationsEnabled,
    @Default(false) bool biometricsEnabled,
    @Default(true) bool privacyModeEnabled,
    @Default(0xFF3F51B5) int themeColor, // Indigo default
  }) = _SettingsState;
}

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void toggleTheme(bool isDark) {
    state =
        state.copyWith(themeMode: isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }

  void setNotificationLeadTime(double value) {
    state = state.copyWith(notificationLeadTime: value);
  }

  void toggleCloudBackup(bool value) {
    state = state.copyWith(cloudBackupEnabled: value);
  }

  void toggleHaptics(bool value) {
    state = state.copyWith(hapticsEnabled: value);
  }

  void toggleAnimations(bool value) {
    state = state.copyWith(animationsEnabled: value);
  }

  void toggleBiometrics(bool value) {
    state = state.copyWith(biometricsEnabled: value);
  }

  void togglePrivacyMode(bool value) {
    state = state.copyWith(privacyModeEnabled: value);
  }

  void updateThemeColor(int colorValue) {
    state = state.copyWith(themeColor: colorValue);
  }
}
