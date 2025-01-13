import 'package:daily_tasks/src/core/utils/extensions/date_time_extension.dart';
import 'package:daily_tasks/src/core/widget/elevated_card.dart';
import 'package:daily_tasks/src/core/widget/space.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// TODO: Добавить награды за определнные трешхолды выполненных задач.
// Например, targetWeight = 10, если выполнено вес заполнен на 2, то одна награда, если на 5, то другая награда и т.д.
// Добавить возможность добавления наград за определенные вес.

const double targetWeight = 10;
const double currentWeight = 3;

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
            const SliverToBoxAdapter(
              child: _SegmentedProgress(),
            ),
            SliverToBoxAdapter(
              child: Space.sm(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Task $index'),
                  subtitle: const Text('Description'),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Text('Value'),
                      Icon(Icons.check_circle),
                    ],
                  ),
                ),
                childCount: 10,
              ),
            ),
          ],
        ),
      );
}

/// {@template _SegmentedProgress}
/// DailyTasksScreen widget.
/// {@endtemplate}
class _SegmentedProgress extends StatefulWidget {
  /// {@macro daily_tasks_screen}
  const _SegmentedProgress({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _SegmentedProgressState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_SegmentedProgressState>();

  @override
  State<_SegmentedProgress> createState() => _SegmentedProgressState();
}

/// State for widget DailyTasksScreen.
class _SegmentedProgressState extends State<_SegmentedProgress> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant _SegmentedProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => ElevatedCard(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
                // child: LinearProgressIndicator(
                //   value: currentWeight / targetWeight,
                // ),
                // Segmented linear progress indicator. Has max value and current value.
                // Creates segments
                ),
            Space.sm(),
            Text(
              'Выполнено: $currentWeight/$targetWeight',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
}
