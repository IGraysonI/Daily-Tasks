import 'package:flutter/widgets.dart';

/// {@template daily_tasks_screen}
/// Screen that displays all daily tasks.
/// {@endtemplate}
class DailyTasksScreen extends StatelessWidget {
  /// {@macro daily_tasks_screen}
  const DailyTasksScreen({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Daily Tasks'),
      );
}
