import 'package:app_database/app_database.dart';

/// {@template daily_tasks_repository}
/// [DailyTasksRepository] for working with [DailyTaskModel].
/// {@endtemplate}
abstract interface class DailyTasksRepository {
  /// Get the [DailyTaskModel] from the source of truth.
  Future<List<DailyTaskModel>> getDailyTasks();

  /// Create the [DailyTaskModel].
  Future<void> createDailyTask(DailyTaskModel dailyTask);
}

/// {@macro daily_tasks_repository}
final class DailyTasksRepositoryImpl implements DailyTasksRepository {
  /// {@macro app_settings_repository}
  // const DailyTasksRepositoryImpl({required this.datasource});
  const DailyTasksRepositoryImpl();
  // TODO(Grayson): Add datasource?

  @override
  Future<void> createDailyTask(DailyTaskModel dailyTask) {
    // TODO(Grayson): implement createDailyTask
    throw UnimplementedError();
  }

  // TODO(Grayson): implement getDailyTasks
  @override
  Future<List<DailyTaskModel>> getDailyTasks() async => [];
}
