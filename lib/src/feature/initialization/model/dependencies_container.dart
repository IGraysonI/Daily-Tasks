import 'package:app_database/app_database.dart';
import 'package:daily_tasks/src/core/constant/application_config.dart';
import 'package:daily_tasks/src/core/utils/logger/logger.dart';
import 'package:daily_tasks/src/feature/daily_tasks/controller/daily_tasks_controller.dart';
import 'package:daily_tasks/src/feature/settings/controller/application_settings_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// {@template dependencies_container}
/// Container used to reuse dependencies across the application.
///
/// {@macro composition_process}
/// {@endtemplate}
class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({
    required this.logger,
    required this.config,
    required this.applicationSettingsController,
    required this.dailyTasksController,
    required this.packageInfo,
    required this.appDatabase,
  });

  /// [Logger] instance, used to log messages.
  final Logger logger;

  /// [ApplicationConfig] instance, contains configuration of the application.
  final ApplicationConfig config;

  /// [ApplicationSettingsController] instance, used to manage application settings.
  final ApplicationSettingsController applicationSettingsController;

  /// [DailyTasksController] instance, used to manage daily tasks.
  final DailyTasksController dailyTasksController;

  /// [PackageInfo] instance, contains information about the application.
  final PackageInfo packageInfo;

  /// [AppDatabase] instance, used to interact with the database.
  final AppDatabase appDatabase;
}

/// {@template testing_dependencies_container}
/// A special version of [DependenciesContainer] that is used in tests.
///
/// In order to use [DependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer implements DependenciesContainer {
  /// {@macro testing_dependencies_container}
  const TestDependenciesContainer();

  @override
  Object noSuchMethod(Invocation invocation) => throw UnimplementedError(
        'The test tries to access ${invocation.memberName} dependency, but '
        'it was not provided. Please provide the dependency in the test. '
        'You can do it by extending this class and providing the dependency.',
      );
}
