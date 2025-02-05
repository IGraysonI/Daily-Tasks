/// {@template tasks_action_enum}
/// An enum that represents the actions that can be performed on both daily and weekly tasks.
/// {@endtemplate}
enum TasksActionEnum {
  /// Add a daily or weekly task to local database.
  add,

  /// Delete a daily or weekly task from local database.
  delete,

  /// Update a daily or weekly task in local database.
  update,

  /// Delete all daily or weekly tasks from local database.
  deleteAll,

  /// Mark a daily or weekly task as done in local database.
  markAsDone,
}
