import 'package:daily_tasks/src/feature/initialization/model/enviroment.dart';

/// Application configuration
class ApplicationConfig {
  /// Creates a new [ApplicationConfig] instance.
  const ApplicationConfig();

  /// The current environment.
  Enviroment get enviroment {
    var env = const String.fromEnvironment('ENVIRONMENT').trim();
    if (env.isNotEmpty) return Enviroment.from(env);
    env = const String.fromEnvironment('FLUTTER_APP_FLAVOR').trim();
    return Enviroment.from(env);
  }

  /// The Sentry DSN.
  String get setnryDsn => const String.fromEnvironment('SENTRY_DSN').trim();

  /// Whether Setnry is enabled.
  bool get isSentryEnabled => setnryDsn.isNotEmpty;
}

/// {@template testing_dependencies_container}
/// A special version of [ApplicationConfig] that is used in tests.
///
/// In order to use [ApplicationConfig] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestConfig extends ApplicationConfig {
  /// {@macro testing_dependencies_container}
  const TestConfig();

  @override
  Object noSuchMethod(Invocation invocation) => throw UnsupportedError(
        'The test tries to access ${invocation.memberName} (${invocation.runtimeType}) config option, but '
        'it was not provided. Please provide the option in the test. '
        'You can do it by extending this class and providing the option.',
      );
}
