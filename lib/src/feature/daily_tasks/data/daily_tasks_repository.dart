import 'package:app_database/app_database.dart';
import 'package:daily_tasks/src/core/enum/tasks_action_enum.dart';
import 'package:daily_tasks/src/feature/daily_tasks/data/daily_tasks_datasource.dart';

/// {@template daily_tasks_repository}
/// [DailyTasksRepository] for working with [DailyTaskModel].
/// {@endtemplate}
abstract interface class DailyTasksRepository {
  /// Get the [DailyTaskModel] as list from the source of truth.
  Future<List<DailyTaskModel>> getDailyTasks();

  /// Get the [DailyTaskModel] as by [id] from the source of truth.
  Future<DailyTaskModel?> getDailyTaskById(String id);

  /// Create the [DailyTaskModel].
  Future<void> manageDailyTasks(
    DailyTaskModel dailyTask,
    TasksActionEnum action,
  );
}

/// {@macro daily_tasks_repository}
final class DailyTasksRepositoryImpl implements DailyTasksRepository {
  /// {@macro app_settings_repository}
  // const DailyTasksRepositoryImpl({required this.datasource});
  const DailyTasksRepositoryImpl({
    required this.dailyTasksDatasource,
  });

  /// The instance of [DailyTasksDatasource] used to interact with the source of truth.
  final DailyTasksDatasource dailyTasksDatasource;

  @override
  Future<List<DailyTaskModel>> getDailyTasks() async => dailyTasksDatasource.getDailyTasks();

  @override
  Future<DailyTaskModel?> getDailyTaskById(String id) async => await dailyTasksDatasource.getDailyTaskById(id);

  @override
  Future<void> manageDailyTasks(DailyTaskModel dailyTask, TasksActionEnum action) => switch (action) {
        TasksActionEnum.add => dailyTasksDatasource.addDailyTask(dailyTask),
        TasksActionEnum.update => dailyTasksDatasource.updateDailyTask(dailyTask),
        TasksActionEnum.delete => dailyTasksDatasource.deleteDailyTask(dailyTask),
        TasksActionEnum.deleteAll => dailyTasksDatasource.deleteAllDailyTasks(),
        TasksActionEnum.markAsDone => throw UnimplementedError(),
      };
}
