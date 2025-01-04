import 'dart:ui';

import 'package:daily_tasks/src/core/utils/color_codec.dart';
import 'package:daily_tasks/src/core/utils/persisted_entry.dart';
import 'package:daily_tasks/src/feature/settings/data/theme_mode_codec.dart';
import 'package:daily_tasks/src/feature/settings/model/application_settings.dart';
import 'package:daily_tasks/src/feature/settings/model/application_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template app_settings_datasource}
/// [ApplicationSettingsDatasource] sets and gets app settings.
/// {@endtemplate}
abstract interface class ApplicationSettingsDatasource {
  /// Set app settings
  Future<void> setApplicationSettings(ApplicationSettings appSettings);

  /// Load [ApplicationSettings] from the source of truth.
  Future<ApplicationSettings?> getApplicationSettings();
}

/// {@macro app_settings_datasource}
final class ApplicationSettingsDatasourceImpl implements ApplicationSettingsDatasource {
  /// {@macro app_settings_datasource}
  ApplicationSettingsDatasourceImpl({required this.sharedPreferences});

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferencesAsync sharedPreferences;

  late final _applicationSettings = AppSettingsPersistedEntry(
    sharedPreferences: sharedPreferences,
    key: 'settings',
  );

  @override
  Future<ApplicationSettings?> getApplicationSettings() => _applicationSettings.read();

  @override
  Future<void> setApplicationSettings(ApplicationSettings applicationSettings) =>
      _applicationSettings.set(applicationSettings);
}

/// Persisted entry for [ApplicationSettings]
class AppSettingsPersistedEntry extends SharedPreferencesEntry<ApplicationSettings> {
  /// Create [AppSettingsPersistedEntry]
  AppSettingsPersistedEntry({required super.sharedPreferences, required super.key});

  late final _themeMode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.themeMode',
  );

  late final _themeSeedColor = IntPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.seedColor',
  );

  late final _localeLanguageCode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.locale.languageCode',
  );

  late final _localeCountryCode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.locale.countryCode',
  );

  late final _textScale = DoublePreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: '$key.textScale',
  );

  @override
  Future<ApplicationSettings?> read() async {
    final themeModeFuture = _themeMode.read();
    final themeSeedColorFuture = _themeSeedColor.read();
    final localeLanguageCodeFuture = _localeLanguageCode.read();
    final countryCodeFuture = _localeCountryCode.read();
    final textScale = await _textScale.read();
    final themeMode = await themeModeFuture;
    final themeSeedColor = await themeSeedColorFuture;
    final languageCode = await localeLanguageCodeFuture;
    final countryCode = await countryCodeFuture;
    if (themeMode == null &&
        themeSeedColor == null &&
        languageCode == null &&
        textScale == null &&
        countryCode == null) {
      return null;
    }
    ApplicationTheme? applicationTheme;
    if (themeMode != null && themeSeedColor != null) {
      applicationTheme = ApplicationTheme(
        themeMode: const ThemeModeCodec().decode(themeMode),
        seed: colorCodec.decode(themeSeedColor),
      );
    }
    Locale? applicationLocale;
    if (languageCode != null) applicationLocale = Locale(languageCode, countryCode);
    return ApplicationSettings(
      applicationTheme: applicationTheme,
      locale: applicationLocale,
      textScale: textScale,
    );
  }

  @override
  Future<void> remove() async => await (
        _themeMode.remove(),
        _themeSeedColor.remove(),
        _localeLanguageCode.remove(),
        _localeCountryCode.remove(),
        _textScale.remove(),
      ).wait;

  @override
  Future<void> set(ApplicationSettings value) async {
    if (value.applicationTheme != null) {
      await (
        _themeMode.set(const ThemeModeCodec().encode(value.applicationTheme!.themeMode)),
        _themeSeedColor.set(colorCodec.encode(value.applicationTheme!.seed)),
      ).wait;
    }
    if (value.locale != null) {
      await (
        _localeLanguageCode.set(value.locale!.languageCode),
        _localeCountryCode.set(value.locale!.countryCode ?? ''),
      ).wait;
    }
    if (value.textScale != null) await _textScale.set(value.textScale!);
  }
}
