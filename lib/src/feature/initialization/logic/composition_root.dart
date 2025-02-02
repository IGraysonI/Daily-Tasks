import 'package:app_database/app_database.dart';
import 'package:clock/clock.dart';
import 'package:daily_tasks/src/core/constant/application_config.dart';
import 'package:daily_tasks/src/core/utils/logger/logger.dart';
import 'package:daily_tasks/src/feature/initialization/model/dependencies_container.dart';
import 'package:daily_tasks/src/feature/settings/controller/application_settings_controller.dart';
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

  /// Application configuration.
  final ApplicationConfig config;

  /// Logger used to log information during composition process.
  final Logger logger;

  /// Composes dependencies and returns the result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();
    logger.info('Initializing dependencies...');

    // Create the dependencies container using functions.
    final dependencies = await createDependenciesContainer(config, logger);
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

  /// The number of milliseconds spent composing dependencies.
  final int millisecondsSpent;

  @override
  String toString() => 'CompositionResult('
      'dependencies: $dependencies, '
      'millisecondsSpent: $millisecondsSpent'
      ')';
}

/// Creates the full dependencies container.
Future<DependenciesContainer> createDependenciesContainer(
  ApplicationConfig config,
  Logger logger,
) async {
  final sharedPreferences = SharedPreferencesAsync();
  final packageInfo = await PackageInfo.fromPlatform();
  final applicationSettingsController = await createAppSettingsController(sharedPreferences);
  final appDatabase = await createAppDatabase();
  return DependenciesContainer(
    logger: logger,
    config: config,
    packageInfo: packageInfo,
    applicationSettingsController: applicationSettingsController,
    appDatabase: appDatabase,
  );
}

/// Creates an instance of [Logger] and attaches any provided observers.
Logger createAppLogger({List<LogObserver> observers = const []}) {
  final logger = Logger();
  for (final observer in observers) {
    logger.addObserver(observer);
  }
  return logger;
}

/// Creates an instance of [ApplicationSettingsController].
///
/// The [ApplicationSettingsController] is initialized at startup to load the app settings from local storage.
Future<ApplicationSettingsController> createAppSettingsController(
  SharedPreferencesAsync sharedPreferences,
) async {
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

/// Creates an instance of [AppDatabase].
///
/// The [AppDatabase] is initialized at startup and used for storing data locally.
Future<AppDatabase> createAppDatabase() async => await AppDatabase.openDatabase();
