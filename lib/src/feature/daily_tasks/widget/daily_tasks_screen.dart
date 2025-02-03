import 'package:control/control.dart';
import 'package:daily_tasks/src/core/utils/extensions/date_time_extension.dart';
import 'package:daily_tasks/src/core/widget/no_data_widget.dart';
import 'package:daily_tasks/src/core/widget/segmented_linear_progress_indicator.dart';
import 'package:daily_tasks/src/core/widget/space.dart';
import 'package:daily_tasks/src/feature/daily_tasks/controller/daily_tasks_controller.dart';
import 'package:daily_tasks/src/feature/daily_tasks/data/daily_tasks_repository.dart';
import 'package:daily_tasks/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';

// TODO(Grayson): Добавить награды за определнные трешхолды выполненных задач.
// Например, targetWeight = 10, если выполнено вес заполнен на 2, то одна награда, если на 5, то другая награда и т.д.
// Добавить возможность добавления наград за определенные вес.

const int _targetWeight = 10;
const int _currentWeight = 3;

/// {@template daily_tasks_screen}
/// Screen that displays all daily tasks.
/// {@endtemplate}
class DailyTasksScreen extends StatefulWidget {
  /// {@macro daily_tasks_screen}
  const DailyTasksScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  late final DailyTasksController _dailyTasksController;
  final _todaysDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dailyTasksController = DailyTasksController(
      dailyTasksRepository: const DailyTasksRepositoryImpl(),
      initialState: const DailyTasksState.idle(dailyTasks: []),
    );
  }

  @override
  void dispose() {
    _dailyTasksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Задачи за ${_todaysDate.dateOnly}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SliverToBoxAdapter(child: Space.sm()),
            StateConsumer<DailyTasksController, DailyTasksState>(
              controller: _dailyTasksController,
              builder: (context, state, child) => state.maybeMap(
                orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
                idle: (state) {
                  if (state.dailyTasks.isEmpty) {
                    return SliverToBoxAdapter(
                      child: NoDataWidget(
                        text: 'Задачи отсутствуют',
                        buttonText: 'Добавить задачу',
                        onPressed: () => DependenciesScope.of(context).logger.info('Add task'),
                      ),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SegmentedLinearProgressIndicator(
                            maxValue: _targetWeight,
                            currentValue: _currentWeight,
                            filledColor: Colors.green,
                            emptyColor: Colors.grey.shade300,
                          ),
                          Space.sm(),
                          const Divider(),
                          Text(
                            'Список задач',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Space.sm(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.dailyTasks.length,
                            itemBuilder: (context, index) {
                              final task = state.dailyTasks[index];
                              return ListTile(
                                title: Text(task.title),
                                subtitle: Text(task.description ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${task.weight}',
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    const Icon(Icons.check_circle),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
}
