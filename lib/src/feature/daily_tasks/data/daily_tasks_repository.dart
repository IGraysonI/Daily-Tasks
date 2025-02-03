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
  // TODO(Grayson): Add datasource?

  @override
  Future<void> createDailyTask(DailyTask dailyTask) {
    // TODO(Grayson): implement createDailyTask
    throw UnimplementedError();
  }

  // TODO(Grayson): implement getDailyTasks
  @override
  Future<List<DailyTask>> getDailyTasks() async => [];
}
