import 'package:app_database/app_database.dart';
import 'package:control/control.dart';
import 'package:daily_tasks/src/core/enum/tasks_action_enum.dart';
import 'package:daily_tasks/src/core/utils/extensions/date_time_extension.dart';
import 'package:daily_tasks/src/core/widget/no_data_widget.dart';
import 'package:daily_tasks/src/core/widget/segmented_linear_progress_indicator.dart';
import 'package:daily_tasks/src/core/widget/space.dart';
import 'package:daily_tasks/src/feature/daily_tasks/controller/daily_tasks_controller.dart';
import 'package:daily_tasks/src/feature/daily_tasks/data/daily_tasks_datasource.dart';
import 'package:daily_tasks/src/feature/daily_tasks/data/daily_tasks_repository.dart';
import 'package:daily_tasks/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      dailyTasksRepository: DailyTasksRepositoryImpl(
        dailyTasksDatasource: DailyTasksDatasourceImpl(
          localDataProvider: LocalDataProvider(DependenciesScope.of(context).appDatabase),
        ),
      ),
      initialState: const DailyTasksState.idle(dailyTasks: []),
    )..getDailyTasks();
  }

  @override
  void dispose() {
    _dailyTasksController.dispose();
    super.dispose();
  }

  // TODO(Grayson): Перенести в отдельный виджет?
  void _showAddTaskDialog(BuildContext context) {
    final taskTitleController = TextEditingController();
    final taskDescriptionController = TextEditingController();
    final taskWeightController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить задачу'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: taskTitleController,
                decoration: const InputDecoration(hintText: 'Название задачи'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название задачи';
                  }
                  return null;
                },
              ),
              Space.sm(),
              TextFormField(
                controller: taskDescriptionController,
                decoration: const InputDecoration(hintText: 'Описание задачи'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите описание задачи';
                  }
                  return null;
                },
              ),
              Space.sm(),
              TextFormField(
                controller: taskWeightController,
                decoration: const InputDecoration(hintText: 'Вес задачи'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите вес задачи';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final dailyTask = DailyTaskModel(
                  id: const Uuid().v4(),
                  title: taskTitleController.text,
                  description: taskDescriptionController.text,
                  weight: int.parse(taskWeightController.text),
                  isCompleted: false,
                );
                _dailyTasksController.manageDailyTasks(dailyTask, TasksActionEnum.add);
                // TODO(Grayson): Показывать сообщение о добавлении задачи
                // ScaffoldMessenger.of(context)
                //   ..removeCurrentSnackBar()
                //   ..showSnackBar(
                //     const SnackBar(content: Text('Задача добавлена')),
                //   );
              } else {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Пожалуйста, заполните все поля')),
                  );
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
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
              builder: (context, state, child) {
                final dailyTasks = state.mapOrNull(idle: (state) => state.dailyTasks);
                if (dailyTasks == null) return const SliverToBoxAdapter(child: SizedBox.shrink());
                if (dailyTasks.isEmpty) {
                  return SliverToBoxAdapter(
                    child: NoDataWidget(
                      text: 'Задачи отсутствуют',
                      buttonText: 'Добавить задачу',
                      onPressed: () => _showAddTaskDialog(context),
                    ),
                  );
                }
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
                        itemCount: dailyTasks.length,
                        itemBuilder: (context, index) {
                          final dailyTask = dailyTasks[index];
                          return ListTile(
                            title: Text(dailyTask.title),
                            subtitle: Text(dailyTask.description ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${dailyTask.weight}',
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
              },
            ),
          ],
        ),
      );
}
