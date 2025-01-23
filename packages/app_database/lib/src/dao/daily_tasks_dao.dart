import 'package:app_database/src/app_database.dart';
import 'package:app_database/src/dao/base/basic_dao.dart';
import 'package:app_database/src/table/daily_tasks.dart';

/// {@template daily_tasks_dao}
/// Dao implementation for [DailyTasks] table
/// {@endtemplate}
class DailyTasksDao extends BasicDao<DailyTasks, DailyTask, AppDatabase> {
  /// {@macro daily_tasks_dao}
  DailyTasksDao(super.attachedDatabase);

  @override
  $DailyTasksTable get daoOnTable => db.dailyTasks;
}
