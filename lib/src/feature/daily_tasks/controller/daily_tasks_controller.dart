import 'package:control/control.dart';
import 'package:daily_tasks/src/core/utils/controller/state_base.dart';
import 'package:daily_tasks/src/feature/daily_tasks/data/daily_tasks_repository.dart';
import 'package:daily_tasks/src/feature/daily_tasks/model/daily_task.dart';
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

  /// Sets the new application settings.
  // void updateDailyTasks({required DailyTasks DailyTasks}) => handle(
//       () async {
  //         setState(
  //           DailyTasksState.processing(
  //             DailyTasks: state.DailyTasks,
  //             message: 'Updating theme',
  //           ),
  //         );
  //         await _dailyTasksRepository.setDailyTasks(DailyTasks);
  //       },
  //       error: (error, _) async => setState(
  //         DailyTasksState.error(
  //           DailyTasks: state.DailyTasks,
  //           error: error,
  //           message: 'Failed to update theme',
  //         ),
  //       ),
  //       done: () async => setState(
  //         DailyTasksState.idle(
  //           DailyTasks: DailyTasks,
  //           message: 'Theme updated',
  //         ),
  //       ),
  //     );
}
