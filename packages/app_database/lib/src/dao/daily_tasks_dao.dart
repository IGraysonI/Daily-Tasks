import 'package:app_database/src/app_database.dart';
import 'package:app_database/src/dao/base/basic_dao.dart';
import 'package:app_database/src/model/daily_task_model.dart';
import 'package:app_database/src/table/daily_tasks.dart';

/// {@template daily_tasks_dao}
/// Dao implementation for [DailyTasks] table
/// {@endtemplate}
class DailyTasksDao extends BasicDao<DailyTasks, DailyTask, AppDatabase> {
  /// {@macro daily_tasks_dao}
  DailyTasksDao(super.attachedDatabase);

  /// Get all tasks and return as a list of [DailyTaskModel]
  Future<List<DailyTaskModel>> getAllTasks() async {
    final tasks = await select(db.dailyTasks).get();
    return tasks.map(DailyTaskModel.fromTable).toList();
  }

  /// Get a task by [taskId] and return as a [DailyTaskModel]
  Future<DailyTaskModel?> getTaskById(String taskId) async {
    final task = await (select(db.dailyTasks)..where((tbl) => tbl.id.equals(taskId))).getSingleOrNull();
    return task != null ? DailyTaskModel.fromTable(task) : null;
  }

  /// Insert a new task into the database
  Future<void> insertTask(DailyTaskModel task) async => await into(db.dailyTasks).insert(task.toTable());

  /// Update a task in the database
  Future<void> updateTask(DailyTaskModel task) async => await update(db.dailyTasks).replace(task.toTable());

  /// Delete a task from the database
  Future<void> deleteTask(DailyTaskModel task) async => await delete(db.dailyTasks).delete(task.toTable());

  /// Delete all tasks from the database
  Future<void> deleteAllTasks() async => await delete(db.dailyTasks).go();

  @override
  $DailyTasksTable get daoOnTable => db.dailyTasks;
}
