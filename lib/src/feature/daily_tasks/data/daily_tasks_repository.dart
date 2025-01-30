import 'package:daily_tasks/src/feature/daily_tasks/model/daily_task.dart';

/// {@template daily_tasks_repository}
/// [DailyTasksRepository] for working with [DailyTask].
/// {@endtemplate}
abstract interface class DailyTasksRepository {
  /// Get the [DailyTask] from the source of truth.
  Future<List<DailyTask>> getDailyTasks();

  /// Create the [DailyTask].
  Future<void> createDailyTask(DailyTask dailyTask);
}

/// {@macro daily_tasks_repository}
final class DailyTasksRepositoryImpl implements DailyTasksRepository {
  /// {@macro app_settings_repository}
  // const DailyTasksRepositoryImpl({required this.datasource});
  const DailyTasksRepositoryImpl();

  @override
  Future<void> createDailyTask(DailyTask dailyTask) {
    // TODO: implement createDailyTask
    throw UnimplementedError();
  }

  @override
  Future<List<DailyTask>> getDailyTasks() {
    // TODO: implement getDailyTasks
    throw UnimplementedError();
  }

  // TODO (Grayson): Add datasource?
}
