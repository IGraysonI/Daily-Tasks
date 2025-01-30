/// {@template daily_task}
/// Model for a daily task.
/// {@endtemplate}
class DailyTask {
  /// {@macro daily_task}
  DailyTask({
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
}
