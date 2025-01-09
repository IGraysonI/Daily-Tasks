import 'package:flutter/material.dart';

/// {@template daily_tasks_screen}
/// Screen that displays all daily tasks.
/// {@endtemplate}
class DailyTasksScreen extends StatelessWidget {
  /// {@macro daily_tasks_screen}
  const DailyTasksScreen({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: LinearProgressIndicator(
                value: 0.5,
              ),
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
