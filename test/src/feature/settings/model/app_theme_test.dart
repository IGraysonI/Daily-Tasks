import 'package:daily_tasks/src/feature/settings/model/application_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'AppTheme',
    () {
      test(
        'should build theme with correct seed color for light theme',
        () {
          // arrange
          const theme = ApplicationTheme.defaultTheme;
          // act
          final themeData = theme.buildThemeData(Brightness.light);
          // assert
          final expectedThemeData = ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: theme.seed),
            useMaterial3: true,
          );
          expect(themeData, expectedThemeData);
          expect(themeData.brightness, Brightness.light);
        },
      );

      test(
        'should build theme with correct seed color for dark theme',
        () {
          // arrange
          const theme = ApplicationTheme.defaultTheme;
          // act
          final themeData = theme.buildThemeData(Brightness.dark);
          // assert
          final expectedThemeData = ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: theme.seed, brightness: Brightness.dark),
            useMaterial3: true,
          );
          expect(themeData, expectedThemeData);
          expect(themeData.brightness, Brightness.dark);
        },
      );
    },
  );
}
