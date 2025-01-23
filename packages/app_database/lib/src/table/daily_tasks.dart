import 'package:app_database/src/base/base_schema.dart';
import 'package:drift/drift.dart';

@DataClassName('DailyTask', extending: BaseDataClass)

/// {@template daily_tasks}
/// Database table for daily tasks
/// {@endtemplate}
class DailyTasks extends BaseSchema {
  @override
  String get tableName => 'DailyTasks';

  /// Title of the task
  TextColumn get title => text()();

  /// Description of the task
  TextColumn get description => text().nullable()();

  /// Weight of the task
  IntColumn get weight => integer()();

  /// Is the task completed
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
