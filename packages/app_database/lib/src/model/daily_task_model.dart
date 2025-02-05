import 'package:app_database/src/app_database.dart';

/// {@template daily_task}
/// Model for a daily task.
/// {@endtemplate}
class DailyTaskModel {
  /// {@macro daily_task}
  DailyTaskModel({
    required this.id,
    required this.title,
    required this.weight,
    required this.isCompleted,
    this.description,
  });

  /// The unique identifier for the task.
  final String id;

  /// The title of the task.
  final String title;

  /// The description of the task.
  final String? description;

  /// The weight of the task.
  final int weight;

  /// Whether the task is completed.
  final bool isCompleted;

  /// Creates a [DailyTaskModel] from a a [DailyTask] table instance.
  factory DailyTaskModel.fromTable(DailyTask data) => DailyTaskModel(
        id: data.id ?? const Uuid().v4(),
        title: data.title,
        description: data.description,
        weight: data.weight,
        isCompleted: data.isCompleted,
      );

  /// Creates a [DailyTask] table instance from this model.
  DailyTask toTable() => DailyTask(
        id: id,
        title: title,
        description: description,
        weight: weight,
        isCompleted: isCompleted,
      );
}
