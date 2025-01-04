import 'dart:ui' show Locale;

import 'package:daily_tasks/src/feature/settings/model/application_theme.dart';
import 'package:flutter/foundation.dart';

/// {@template app_settings}
/// Application settings
/// {@endtemplate}
class ApplicationSettings with Diagnosticable {
  /// {@macro app_settings}
  const ApplicationSettings({this.applicationTheme, this.locale, this.textScale});

  /// The theme of the app,
  final ApplicationTheme? applicationTheme;

  /// The locale of the app.
  final Locale? locale;

  /// The text scale of the app.
  final double? textScale;

  /// Copy the [ApplicationSettings] with new values.
  ApplicationSettings copyWith({
    ApplicationTheme? applicationTheme,
    Locale? locale,
    double? textScale,
  }) =>
      ApplicationSettings(
        applicationTheme: applicationTheme ?? this.applicationTheme,
        locale: locale ?? this.locale,
        textScale: textScale ?? this.textScale,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApplicationSettings &&
        other.applicationTheme == applicationTheme &&
        other.locale == locale &&
        other.textScale == textScale;
  }

  @override
  int get hashCode => Object.hash(applicationTheme, locale, textScale);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<ApplicationTheme>('appTheme', applicationTheme));
    properties.add(DiagnosticsProperty<Locale>('locale', locale));
    properties.add(DoubleProperty('textScale', textScale));
    super.debugFillProperties(properties);
  }
}
