part of 'daily_tasks_controller.dart';

/// Pattern matching for [DailyTasksState].
typedef DailyTasksStateMatch<R, S extends DailyTasksState> = R Function(S state);

/// DailyTasksState.
sealed class DailyTasksState extends _$DailyTaskStateBase {
  /// {@macro daily_tasks_state}
  const DailyTasksState({
    required super.dailyTasks,
    required super.message,
  });

  /// Idling state
  /// {@macro daily_tasks_state}
  const factory DailyTasksState.idle({
    List<DailyTask> dailyTasks,
    String message,
  }) = DailyTaskState$Idle;

  /// Processing
  /// {@macro daily_tasks_state}
  const factory DailyTasksState.processing({
    List<DailyTask> dailyTasks,
    String message,
  }) = DailyTaskState$Processing;

  /// An error has occurred
  /// {@macro daily_tasks_state}
  const factory DailyTasksState.error({
    required Object error,
    List<DailyTask>? dailyTasks,
    String message,
  }) = DailyTaskState$Error;
}

/// {@template DailyTasksState$Idle}
/// Idling state
/// {@endtemplate}
final class DailyTaskState$Idle extends DailyTasksState {
  /// Idling state
  const DailyTaskState$Idle({
    super.dailyTasks,
    super.message = 'Idling',
  });
}

/// {@template DailyTasksState$Processing}
/// Processing
/// {@endtemplate}
final class DailyTaskState$Processing extends DailyTasksState {
  /// Processing
  const DailyTaskState$Processing({
    super.dailyTasks,
    super.message = 'Processing ',
  });
}

/// {@template DailyTasksState$Error}
/// An error has occurred
/// {@endtemplate}
final class DailyTaskState$Error extends DailyTasksState {
  /// An error has occurred
  const DailyTaskState$Error({
    required this.error,
    super.dailyTasks,
    super.message = 'An error has occurred',
  });

  /// The error that occurred
  final Object error;
}

@immutable
abstract base class _$DailyTaskStateBase extends StateBase<DailyTasksState> {
  const _$DailyTaskStateBase({
    required this.dailyTasks,
    required super.message,
  });

  /// List of the daily tasks.
  @nonVirtual
  final List<DailyTask>? dailyTasks;

  /// Pattern matching for [DailyTasksState].
  @override
  R map<R>({
    required DailyTasksStateMatch<R, DailyTaskState$Idle> idle,
    required DailyTasksStateMatch<R, DailyTaskState$Processing> processing,
    required DailyTasksStateMatch<R, DailyTaskState$Error> error,
  }) =>
      switch (this) {
        final DailyTaskState$Idle s => idle(s),
        final DailyTaskState$Processing s => processing(s),
        final DailyTaskState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [DailyTasksState].
  @override
  R maybeMap<R>({
    required R Function() orElse,
    DailyTasksStateMatch<R, DailyTaskState$Idle>? idle,
    DailyTasksStateMatch<R, DailyTaskState$Processing>? processing,
    DailyTasksStateMatch<R, DailyTaskState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [DailyTasksState].
  @override
  R? mapOrNull<R>({
    DailyTasksStateMatch<R, DailyTaskState$Idle>? idle,
    DailyTasksStateMatch<R, DailyTaskState$Processing>? processing,
    DailyTasksStateMatch<R, DailyTaskState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        error: error ?? (_) => null,
      );

  /// Copy with method for [DailyTasksState].
  @override
  DailyTasksState copyWith({
    List<DailyTask>? dailyTasks,
    String? message,
    String? error,
  }) =>
      map(
        idle: (s) => s.copyWith(
          dailyTasks: dailyTasks ?? s.dailyTasks,
          message: message ?? s.message,
        ),
        processing: (s) => s.copyWith(
          dailyTasks: dailyTasks ?? s.dailyTasks,
          message: message ?? s.message,
        ),
        error: (s) => s.copyWith(
          dailyTasks: dailyTasks ?? s.dailyTasks,
          message: message ?? s.message,
        ),
      );

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('DailyTasksState(')
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
