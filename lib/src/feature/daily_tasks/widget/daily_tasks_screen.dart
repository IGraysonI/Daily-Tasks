import 'package:daily_tasks/src/core/utils/extensions/date_time_extension.dart';
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
              child: _SegmentedLinearProgressIndicator(
                maxValue: _targetWeight,
                currentValue: _currentWeight,
                primaryColor: Colors.green,
                secondaryColor: Colors.grey.shade300,
              ),
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

class _SegmentedLinearProgressIndicator extends StatelessWidget {
  final int maxValue;
  final int currentValue;
  final Color primaryColor;
  final Color secondaryColor;

  const _SegmentedLinearProgressIndicator({
    required this.maxValue,
    required this.currentValue,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
  }) : assert(maxValue <= 15, 'maxValue cannot be greater than 15');

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / maxValue;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              maxValue,
              (index) => SizedBox(
                width: segmentWidth,
                height: 20,
                child: CustomPaint(
                  painter: _SegmentPainter(
                    isFilled: index < currentValue,
                    primaryColor: primaryColor,
                    secondaryColor: secondaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class _SegmentPainter extends CustomPainter {
  final bool isFilled;
  final Color primaryColor;
  final Color secondaryColor;

  _SegmentPainter({
    required this.isFilled,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isFilled ? primaryColor : secondaryColor
      ..style = PaintingStyle.fill;
    const tiltOffset = 20.0;

    final path = Path()
      ..moveTo(tiltOffset, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - tiltOffset, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
