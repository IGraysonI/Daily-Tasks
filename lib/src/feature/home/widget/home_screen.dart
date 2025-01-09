import 'package:daily_tasks/src/feature/daily_tasks/widget/daily_tasks_screen.dart';
import 'package:daily_tasks/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:daily_tasks/src/feature/weekly_tasks/widget/weekly_tasks_screen.dart';
import 'package:flutter/material.dart';

/// {@template home_screen}
/// HomeScreen is a simple screen that displays a grid of items.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final _logger = DependenciesScope.of(context).logger;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _logger.info('Welcome To Sizzle Starter!');
    _tabController = TabController(length: 2, vsync: this);
  }

  final List<Widget> _tabs = [
    const Tab(text: 'Daily Tasks'),
    const Tab(text: 'Weekly Tasks'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          bottom: TabBar(
            tabs: _tabs,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            DailyTasksScreen(),
            WeeklyTasksScreen(),
          ],
        ),
      );
}
