import 'package:app_database/app_database.dart';
import 'package:clock/clock.dart';
import 'package:daily_tasks/src/core/constant/application_config.dart';
import 'package:daily_tasks/src/core/utils/error_reporter/error_reporter.dart';
import 'package:daily_tasks/src/core/utils/logger/logger.dart';
import 'package:daily_tasks/src/feature/initialization/model/dependencies_container.dart';
import 'package:daily_tasks/src/feature/settings/controller/application_settings_state.dart';
import 'package:daily_tasks/src/feature/settings/controller/settings_controller.dart';
import 'package:daily_tasks/src/feature/settings/data/application_settings_datasource.dart';
import 'package:daily_tasks/src/feature/settings/data/application_settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template composition_root}
/// A place where top-level dependencies are initialized.
/// {@endtemplate}
///
/// {@template composition_process}
/// Composition of dependencies is a process of creating and configuring
/// instances of classes that are required for the application to work.
/// {@endtemplate}
final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot({
    required this.config,
    required this.logger,
  });

  /// Application configuration
  final ApplicationConfig config;

  /// Logger used to log information during composition process.
  final Logger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();
    logger.info('Initializing dependencies...');

    // initialize dependencies
    final dependencies = await DependenciesFactory(
      config: config,
      logger: logger,
    ).create();
    stopwatch.stop();
    logger.info('Dependencies initialized successfully in ${stopwatch.elapsedMilliseconds} ms.');
    final result = CompositionResult(
      dependencies: dependencies,
      millisecondsSpent: stopwatch.elapsedMilliseconds,
    );
    return result;
  }
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.millisecondsSpent,
  });

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int millisecondsSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'millisecondsSpent: $millisecondsSpent'
      ')';
}

/// Value with time.
typedef ValueWithTime<T> = ({T value, Duration timeSpent});

/// {@template factory}
/// Factory that creates an instance of [T].
/// {@endtemplate}
abstract class Factory<T> {
  /// {@macro factory}
  const Factory();

  /// Creates an instance of [T].
  T create();
}

/// {@template async_factory}
/// Factory that creates an instance of [T] asynchronously.
/// {@endtemplate}
abstract class AsyncFactory<T> {
  /// {@macro async_factory}
  const AsyncFactory();

  /// Creates an instance of [T].
  Future<T> create();
}

/// {@template dependencies_factory}
/// Factory that creates an instance of [DependenciesContainer].
/// {@endtemplate}
class DependenciesFactory extends AsyncFactory<DependenciesContainer> {
  /// {@macro dependencies_factory}
  const DependenciesFactory({
    required this.config,
    required this.logger,
  });

  /// Application configuration
  final ApplicationConfig config;

  /// Logger used to log information during composition process.
  final Logger logger;

  @override
  Future<DependenciesContainer> create() async {
    final sharedPreferences = SharedPreferencesAsync();
    final packageInfo = await PackageInfo.fromPlatform();
    final applicationSettingsController = await ApplicationSettingsControllerFactory(sharedPreferences).create();
    final appDatabase = await const AppDatabaseFactory().create();
    return DependenciesContainer(
      logger: logger,
      config: config,
      applicationSettingsController: applicationSettingsController,
      packageInfo: packageInfo,
      appDatabase: appDatabase,
    );
  }
}

/// {@template app_logger_factory}
/// Factory that creates an instance of [AppLogger].
/// {@endtemplate}
class ApplicationLoggerFactory extends Factory<AppLogger> {
  /// {@macro app_logger_factory}
  const ApplicationLoggerFactory({this.observers = const []});

  /// List of observers that will be notified when a log message is received.
  final List<LogObserver> observers;

  @override
  AppLogger create() => AppLogger(observers: observers);
}

/// {@template error_reporter_factory}
/// Factory that creates an instance of [ErrorReporter].
/// {@endtemplate}
// TODO(Grayson): Add sentry?
// class ErrorReporterFactory extends AsyncFactory<ErrorReporter> {
//   /// {@macro error_reporter_factory}
//   const ErrorReporterFactory(this.config);

//   /// Application configuration
//   final ApplicationConfig config;

//   @override
//   Future<ErrorReporter> create() async {
//     final errorReporter = SentryErrorReporter(
//       sentryDsn: config.sentryDsn,
//       environment: config.environment.value,
//     );

//     if (config.sentryDsn.isNotEmpty) {
//       await errorReporter.initialize();
//     }

//     return errorReporter;
//   }
// }

/// {@template app_settings_bloc_factory}
/// Factory that creates an instance of [ApplicationSettingsController].
///
/// The [ApplicationSettingsController] should be initialized during the application startup
/// in order to load the app settings from the local storage, so user can see
/// their selected theme,locale, etc.
/// {@endtemplate}
class ApplicationSettingsControllerFactory extends AsyncFactory<ApplicationSettingsController> {
  /// {@macro app_settings_bloc_factory}
  const ApplicationSettingsControllerFactory(this.sharedPreferences);

  /// Shared preferences instance
  final SharedPreferencesAsync sharedPreferences;

  @override
  Future<ApplicationSettingsController> create() async {
    final applicationSettingsRepository = ApplicationSettingsRepositoryImpl(
      datasource: ApplicationSettingsDatasourceImpl(sharedPreferences: sharedPreferences),
    );
    final applicationSettings = await applicationSettingsRepository.getApplicationSettings();
    final initialState = ApplicationSettingsState.idle(applicationSettings: applicationSettings);
    return ApplicationSettingsController(
      applicaitonSettingsRepository: applicationSettingsRepository,
      initialState: initialState,
    );
  }
}

/// {@template composition_root}
/// Factory that creates an instance of [AppDatabase].
/// {@endtemplate}
class AppDatabaseFactory extends AsyncFactory<AppDatabase> {
  /// {@macro app_database_factory}
  const AppDatabaseFactory();

  @override
  Future<AppDatabase> create() async => await AppDatabase.openDatabase();
}
