// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsState {
  ThemeMode get themeMode;
  bool get notificationsEnabled;
  double get notificationLeadTime;
  bool get cloudBackupEnabled;
  bool get hapticsEnabled;
  bool get animationsEnabled;
  bool get biometricsEnabled;
  bool get privacyModeEnabled;
  int get themeColor;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      _$SettingsStateCopyWithImpl<SettingsState>(
          this as SettingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsState &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.notificationLeadTime, notificationLeadTime) ||
                other.notificationLeadTime == notificationLeadTime) &&
            (identical(other.cloudBackupEnabled, cloudBackupEnabled) ||
                other.cloudBackupEnabled == cloudBackupEnabled) &&
            (identical(other.hapticsEnabled, hapticsEnabled) ||
                other.hapticsEnabled == hapticsEnabled) &&
            (identical(other.animationsEnabled, animationsEnabled) ||
                other.animationsEnabled == animationsEnabled) &&
            (identical(other.biometricsEnabled, biometricsEnabled) ||
                other.biometricsEnabled == biometricsEnabled) &&
            (identical(other.privacyModeEnabled, privacyModeEnabled) ||
                other.privacyModeEnabled == privacyModeEnabled) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      notificationsEnabled,
      notificationLeadTime,
      cloudBackupEnabled,
      hapticsEnabled,
      animationsEnabled,
      biometricsEnabled,
      privacyModeEnabled,
      themeColor);

  @override
  String toString() {
    return 'SettingsState(themeMode: $themeMode, notificationsEnabled: $notificationsEnabled, notificationLeadTime: $notificationLeadTime, cloudBackupEnabled: $cloudBackupEnabled, hapticsEnabled: $hapticsEnabled, animationsEnabled: $animationsEnabled, biometricsEnabled: $biometricsEnabled, privacyModeEnabled: $privacyModeEnabled, themeColor: $themeColor)';
  }
}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) _then) =
      _$SettingsStateCopyWithImpl;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool notificationsEnabled,
      double notificationLeadTime,
      bool cloudBackupEnabled,
      bool hapticsEnabled,
      bool animationsEnabled,
      bool biometricsEnabled,
      bool privacyModeEnabled,
      int themeColor});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? notificationsEnabled = null,
    Object? notificationLeadTime = null,
    Object? cloudBackupEnabled = null,
    Object? hapticsEnabled = null,
    Object? animationsEnabled = null,
    Object? biometricsEnabled = null,
    Object? privacyModeEnabled = null,
    Object? themeColor = null,
  }) {
    return _then(_self.copyWith(
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      notificationsEnabled: null == notificationsEnabled
          ? _self.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationLeadTime: null == notificationLeadTime
          ? _self.notificationLeadTime
          : notificationLeadTime // ignore: cast_nullable_to_non_nullable
              as double,
      cloudBackupEnabled: null == cloudBackupEnabled
          ? _self.cloudBackupEnabled
          : cloudBackupEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      hapticsEnabled: null == hapticsEnabled
          ? _self.hapticsEnabled
          : hapticsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      animationsEnabled: null == animationsEnabled
          ? _self.animationsEnabled
          : animationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      biometricsEnabled: null == biometricsEnabled
          ? _self.biometricsEnabled
          : biometricsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      privacyModeEnabled: null == privacyModeEnabled
          ? _self.privacyModeEnabled
          : privacyModeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeColor: null == themeColor
          ? _self.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            ThemeMode themeMode,
            bool notificationsEnabled,
            double notificationLeadTime,
            bool cloudBackupEnabled,
            bool hapticsEnabled,
            bool animationsEnabled,
            bool biometricsEnabled,
            bool privacyModeEnabled,
            int themeColor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(
            _that.themeMode,
            _that.notificationsEnabled,
            _that.notificationLeadTime,
            _that.cloudBackupEnabled,
            _that.hapticsEnabled,
            _that.animationsEnabled,
            _that.biometricsEnabled,
            _that.privacyModeEnabled,
            _that.themeColor);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            ThemeMode themeMode,
            bool notificationsEnabled,
            double notificationLeadTime,
            bool cloudBackupEnabled,
            bool hapticsEnabled,
            bool animationsEnabled,
            bool biometricsEnabled,
            bool privacyModeEnabled,
            int themeColor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState():
        return $default(
            _that.themeMode,
            _that.notificationsEnabled,
            _that.notificationLeadTime,
            _that.cloudBackupEnabled,
            _that.hapticsEnabled,
            _that.animationsEnabled,
            _that.biometricsEnabled,
            _that.privacyModeEnabled,
            _that.themeColor);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            ThemeMode themeMode,
            bool notificationsEnabled,
            double notificationLeadTime,
            bool cloudBackupEnabled,
            bool hapticsEnabled,
            bool animationsEnabled,
            bool biometricsEnabled,
            bool privacyModeEnabled,
            int themeColor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsState() when $default != null:
        return $default(
            _that.themeMode,
            _that.notificationsEnabled,
            _that.notificationLeadTime,
            _that.cloudBackupEnabled,
            _that.hapticsEnabled,
            _that.animationsEnabled,
            _that.biometricsEnabled,
            _that.privacyModeEnabled,
            _that.themeColor);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettingsState implements SettingsState {
  const _SettingsState(
      {this.themeMode = ThemeMode.system,
      this.notificationsEnabled = true,
      this.notificationLeadTime = 15.0,
      this.cloudBackupEnabled = false,
      this.hapticsEnabled = true,
      this.animationsEnabled = true,
      this.biometricsEnabled = false,
      this.privacyModeEnabled = true,
      this.themeColor = 0xFF3F51B5});

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final double notificationLeadTime;
  @override
  @JsonKey()
  final bool cloudBackupEnabled;
  @override
  @JsonKey()
  final bool hapticsEnabled;
  @override
  @JsonKey()
  final bool animationsEnabled;
  @override
  @JsonKey()
  final bool biometricsEnabled;
  @override
  @JsonKey()
  final bool privacyModeEnabled;
  @override
  @JsonKey()
  final int themeColor;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsStateCopyWith<_SettingsState> get copyWith =>
      __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsState &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.notificationLeadTime, notificationLeadTime) ||
                other.notificationLeadTime == notificationLeadTime) &&
            (identical(other.cloudBackupEnabled, cloudBackupEnabled) ||
                other.cloudBackupEnabled == cloudBackupEnabled) &&
            (identical(other.hapticsEnabled, hapticsEnabled) ||
                other.hapticsEnabled == hapticsEnabled) &&
            (identical(other.animationsEnabled, animationsEnabled) ||
                other.animationsEnabled == animationsEnabled) &&
            (identical(other.biometricsEnabled, biometricsEnabled) ||
                other.biometricsEnabled == biometricsEnabled) &&
            (identical(other.privacyModeEnabled, privacyModeEnabled) ||
                other.privacyModeEnabled == privacyModeEnabled) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      notificationsEnabled,
      notificationLeadTime,
      cloudBackupEnabled,
      hapticsEnabled,
      animationsEnabled,
      biometricsEnabled,
      privacyModeEnabled,
      themeColor);

  @override
  String toString() {
    return 'SettingsState(themeMode: $themeMode, notificationsEnabled: $notificationsEnabled, notificationLeadTime: $notificationLeadTime, cloudBackupEnabled: $cloudBackupEnabled, hapticsEnabled: $hapticsEnabled, animationsEnabled: $animationsEnabled, biometricsEnabled: $biometricsEnabled, privacyModeEnabled: $privacyModeEnabled, themeColor: $themeColor)';
  }
}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(
          _SettingsState value, $Res Function(_SettingsState) _then) =
      __$SettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool notificationsEnabled,
      double notificationLeadTime,
      bool cloudBackupEnabled,
      bool hapticsEnabled,
      bool animationsEnabled,
      bool biometricsEnabled,
      bool privacyModeEnabled,
      int themeColor});
}

/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? themeMode = null,
    Object? notificationsEnabled = null,
    Object? notificationLeadTime = null,
    Object? cloudBackupEnabled = null,
    Object? hapticsEnabled = null,
    Object? animationsEnabled = null,
    Object? biometricsEnabled = null,
    Object? privacyModeEnabled = null,
    Object? themeColor = null,
  }) {
    return _then(_SettingsState(
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      notificationsEnabled: null == notificationsEnabled
          ? _self.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationLeadTime: null == notificationLeadTime
          ? _self.notificationLeadTime
          : notificationLeadTime // ignore: cast_nullable_to_non_nullable
              as double,
      cloudBackupEnabled: null == cloudBackupEnabled
          ? _self.cloudBackupEnabled
          : cloudBackupEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      hapticsEnabled: null == hapticsEnabled
          ? _self.hapticsEnabled
          : hapticsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      animationsEnabled: null == animationsEnabled
          ? _self.animationsEnabled
          : animationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      biometricsEnabled: null == biometricsEnabled
          ? _self.biometricsEnabled
          : biometricsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      privacyModeEnabled: null == privacyModeEnabled
          ? _self.privacyModeEnabled
          : privacyModeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeColor: null == themeColor
          ? _self.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
