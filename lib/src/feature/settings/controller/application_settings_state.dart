part of 'application_settings_controller.dart';

/// Pattern matching for [ApplicationSettingsState].
typedef ApplicationSettingsStateMatch<R, S extends ApplicationSettingsState> = R Function(S state);

/// SettingState.
sealed class ApplicationSettingsState extends _$ApplicationSettingStateBase {
  /// {@macro setting_state}
  const ApplicationSettingsState({
    required super.applicationSettings,
    required super.message,
  });

  /// Idling state
  /// {@macro setting_state}
  const factory ApplicationSettingsState.idle({
    ApplicationSettings? applicationSettings,
    String message,
  }) = ApplicationSettingState$Idle;

  /// Processing
  /// {@macro setting_state}
  const factory ApplicationSettingsState.processing({
    ApplicationSettings? applicationSettings,
    String message,
  }) = ApplicationSettingState$Processing;

  /// Successful
  /// {@macro setting_state}
  const factory ApplicationSettingsState.successful({
    ApplicationSettings? applicationSettings,
    String message,
  }) = ApplicationSettingState$Successful;

  /// An error has occurred
  /// {@macro setting_state}
  const factory ApplicationSettingsState.error({
    required Object error,
    ApplicationSettings? applicationSettings,
    String message,
  }) = ApplicationSettingState$Error;
}

/// {@template SettingState$Idle}
/// Idling state
/// {@endtemplate}
final class ApplicationSettingState$Idle extends ApplicationSettingsState {
  /// Idling state
  const ApplicationSettingState$Idle({
    super.applicationSettings,
    super.message = 'Idling',
  });
}

/// {@template SettingState$Processing}
/// Processing
/// {@endtemplate}
final class ApplicationSettingState$Processing extends ApplicationSettingsState {
  /// Processing
  const ApplicationSettingState$Processing({
    super.applicationSettings,
    super.message = 'Processing ',
  });
}

/// {@template SettingState$Successful}
/// Successful
/// {@endtemplate}
final class ApplicationSettingState$Successful extends ApplicationSettingsState {
  /// Successful
  const ApplicationSettingState$Successful({
    super.applicationSettings,
    super.message = 'Successful',
  });
}

/// {@template SettingState$Error}
/// An error has occurred
/// {@endtemplate}
final class ApplicationSettingState$Error extends ApplicationSettingsState {
  /// An error has occurred
  const ApplicationSettingState$Error({
    required this.error,
    super.applicationSettings,
    super.message = 'An error has occurred',
  });

  /// The error that occurred
  final Object error;
}

@immutable
abstract base class _$ApplicationSettingStateBase extends StateBase<ApplicationSettingsState> {
  const _$ApplicationSettingStateBase({
    required this.applicationSettings,
    required super.message,
  });

  /// Locale of the application.
  @nonVirtual
  final ApplicationSettings? applicationSettings;

  /// Pattern matching for [ApplicationSettingsState].
  @override
  R map<R>({
    required ApplicationSettingsStateMatch<R, ApplicationSettingState$Idle> idle,
    required ApplicationSettingsStateMatch<R, ApplicationSettingState$Processing> processing,
    required ApplicationSettingsStateMatch<R, ApplicationSettingState$Successful> successful,
    required ApplicationSettingsStateMatch<R, ApplicationSettingState$Error> error,
  }) =>
      switch (this) {
        final ApplicationSettingState$Idle s => idle(s),
        final ApplicationSettingState$Processing s => processing(s),
        final ApplicationSettingState$Successful s => successful(s),
        final ApplicationSettingState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [ApplicationSettingsState].
  @override
  R maybeMap<R>({
    required R Function() orElse,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Idle>? idle,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Processing>? processing,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Successful>? successful,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [ApplicationSettingsState].
  @override
  R? mapOrNull<R>({
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Idle>? idle,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Processing>? processing,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Successful>? successful,
    ApplicationSettingsStateMatch<R, ApplicationSettingState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  /// Copy with method for [ApplicationSettingsState].
  @override
  ApplicationSettingsState copyWith({
    ApplicationSettings? applicationSettings,
    String? message,
    String? error,
  }) =>
      map(
        idle: (s) => s.copyWith(
          applicationSettings: applicationSettings ?? s.applicationSettings,
          message: message ?? s.message,
        ),
        processing: (s) => s.copyWith(
          applicationSettings: applicationSettings ?? s.applicationSettings,
          message: message ?? s.message,
        ),
        successful: (s) => s.copyWith(
          applicationSettings: applicationSettings ?? s.applicationSettings,
          message: message ?? s.message,
        ),
        error: (s) => s.copyWith(
          applicationSettings: applicationSettings ?? s.applicationSettings,
          message: message ?? s.message,
        ),
      );

  @override
  // TODO(Grayson): add more properties
  String toString() {
    final buffer = StringBuffer()
      ..write('SettingState(')
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
