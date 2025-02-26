import 'package:app_database/app_database.dart';
import 'package:control/control.dart';
import 'package:daily_tasks/src/core/enum/tasks_action_enum.dart';
import 'package:daily_tasks/src/core/utils/controller/state_base.dart';
import 'package:daily_tasks/src/feature/daily_tasks/data/daily_tasks_repository.dart';
import 'package:meta/meta.dart';

part 'daily_tasks_state.dart';

/// {@template daily_tasks_controller}
/// Controller for managing and viewing daily tasks.
/// {@endtemplate}
final class DailyTasksController extends StateController<DailyTasksState> with DroppableControllerHandler {
  /// {@macro daily_tasks_controller}
  DailyTasksController({
    required DailyTasksRepository dailyTasksRepository,
    required super.initialState,
  }) : _dailyTasksRepository = dailyTasksRepository;

  final DailyTasksRepository _dailyTasksRepository;

  /// Add a new [DailyTaskModel]
  void manageDailyTasks(
    DailyTaskModel dailyTask,
    TasksActionEnum action,
  ) =>
      handle(
        () async {
          setState(
            DailyTasksState.processing(
              dailyTasks: state.dailyTasks,
              message: 'Updating theme',
            ),
          );
          await _dailyTasksRepository.manageDailyTasks(dailyTask, action);
        },
        error: (error, _) async => setState(
          DailyTasksState.error(
            dailyTasks: state.dailyTasks,
            error: error,
            message: 'Failed to update theme',
          ),
        ),
        done: () async => setState(
          DailyTasksState.idle(
            dailyTasks: state.dailyTasks,
            message: 'Theme updated',
          ),
        ),
      );

  /// Get the list of [DailyTaskModel]
  void fetchDailyTasks() => handle(
        () async {
          setState(
            DailyTasksState.processing(
              dailyTasks: state.dailyTasks,
              message: 'Preparing to get daily tasks',
            ),
          );
          final dailyTasks = await _dailyTasksRepository.getDailyTasks();
          setState(
            DailyTasksState.successful(
              dailyTasks: dailyTasks,
              message: 'Daily tasks retrieved',
            ),
          );
        },
        error: (error, _) async => setState(
          DailyTasksState.error(
            dailyTasks: state.dailyTasks,
            error: error,
            message: 'Failed to get daily tasks',
          ),
        ),
        done: () async => setState(
          DailyTasksState.idle(
            dailyTasks: state.dailyTasks,
            message: 'Daily tasks idle',
          ),
        ),
      );
}
