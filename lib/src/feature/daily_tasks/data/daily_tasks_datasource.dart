import 'package:app_database/app_database.dart';

/// {@template daily_tasks_datasource}
/// [DailyTasksDatasource] sets and gets app settings.
/// {@endtemplate}
abstract interface class DailyTasksDatasource {
  /// Gel all [DailyTaskModel] from the local database.
  Future<List<DailyTaskModel>> getDailyTasks();

  /// Get the [DailyTaskModel] by [id] from the local database.
  Future<DailyTaskModel?> getDailyTaskById(String id);

  /// Add [DailyTaskModel] to the local database.
  Future<void> addDailyTask(DailyTaskModel dailyTask);

  /// Update [DailyTaskModel] in the local database.
  Future<void> updateDailyTask(DailyTaskModel dailyTask);

  /// Remove [DailyTaskModel] from the local database.
  Future<void> deleteDailyTask(DailyTaskModel dailyTask);

  /// Remove all [DailyTaskModel] from the local database.
  Future<void> deleteAllDailyTasks();

  /// Mark [DailyTaskModel] as done in the local database.
  Future<void> markAsDone(DailyTaskModel dailyTask);
}

/// {@macro daily_tasks_datasource}
final class DailyTasksDatasourceImpl implements DailyTasksDatasource {
  /// {@macro daily_tasks_datasource}
  DailyTasksDatasourceImpl({required this.localDataProvider});

  /// [LocalDataProvider] for working with [DailyTaskModel] data from local storage.
  final LocalDataProvider localDataProvider;

  @override
  Future<void> addDailyTask(DailyTaskModel dailyTask) =>
      localDataProvider.getDao<DailyTasksDao>().insertTask(dailyTask);

  @override
  Future<DailyTaskModel?> getDailyTaskById(String id) => localDataProvider.getDao<DailyTasksDao>().getTaskById(id);

  @override
  Future<List<DailyTaskModel>> getDailyTasks() => localDataProvider.getDao<DailyTasksDao>().getAllTasks();

  // TODO(Grayson): implement markAsDone
  @override
  Future<void> markAsDone(DailyTaskModel dailyTask) => throw UnimplementedError();

  @override
  Future<void> deleteAllDailyTasks() => localDataProvider.getDao<DailyTasksDao>().deleteAllTasks();

  @override
  Future<void> deleteDailyTask(DailyTaskModel dailyTask) =>
      localDataProvider.getDao<DailyTasksDao>().deleteTask(dailyTask);

  @override
  Future<void> updateDailyTask(DailyTaskModel dailyTask) =>
      localDataProvider.getDao<DailyTasksDao>().updateTask(dailyTask);
}
