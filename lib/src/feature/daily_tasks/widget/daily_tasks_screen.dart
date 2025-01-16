import 'package:daily_tasks/src/core/utils/extensions/date_time_extension.dart';
import 'package:daily_tasks/src/core/widget/segmented_linear_progress_indicator.dart';
import 'package:daily_tasks/src/core/widget/space.dart';
import 'package:flutter/material.dart';

// TODO: Добавить награды за определнные трешхолды выполненных задач.
// Например, targetWeight = 10, если выполнено вес заполнен на 2, то одна награда, если на 5, то другая награда и т.д.
// Добавить возможность добавления наград за определенные вес.

const int _targetWeight = 10;
const int _currentWeight = 3;

class _DailyTask {
  final String title;
  final String description;
  final int weight;
  final bool isCompleted;

  _DailyTask({
    required this.title,
    required this.description,
    required this.weight,
    required this.isCompleted,
  });

  // Dummy tasks for mock up purposes
  static List<_DailyTask> get mockUpTasks => List.generate(
        10,
        (index) => _DailyTask(
          title: 'Task $index',
          description: 'Description',
          weight: index % 3 + 1,
          isCompleted: false,
        ),
      );
}

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
  final _todaysDate = DateTime.now();
  final List<_DailyTask> _mockUpTasks = _DailyTask.mockUpTasks;

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
            SliverToBoxAdapter(
              child: Space.sm(),
            ),
            SliverToBoxAdapter(
              child: SegmentedLinearProgressIndicator(
                maxValue: _targetWeight,
                currentValue: _currentWeight,
                filledColor: Colors.green,
                emptyColor: Colors.grey.shade300,
              ),
            ),
            SliverToBoxAdapter(child: Space.sm()),
            const SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: Text(
                'Список задач',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SliverToBoxAdapter(child: Space.sm()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text(_mockUpTasks[index].title),
                  subtitle: Text(_mockUpTasks[index].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Text(
                        '${_mockUpTasks[index].weight}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Icon(Icons.check_circle),
                    ],
                  ),
                ),
                childCount: _mockUpTasks.length,
              ),
            ),
          ],
        ),
      );
}
