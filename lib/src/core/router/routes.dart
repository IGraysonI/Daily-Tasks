import 'package:daily_tasks/src/feature/home/widget/home_screen.dart';
import 'package:daily_tasks/src/feature/weekly_tasks/widget/weekly_tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

/// {@template routes}
/// Enum that contains all the routes of the application.
/// {@endtemplate}
enum Routes with OctopusRoute {
  /// Home route.
  home('home', title: 'Home'),

  /// Daily tasks route.
  dailyTasks('dailyTasks', title: 'Daily Tasks'),

  /// Weekly tasks route.
  weeklyTasks('weeklyTasks', title: 'Weekly Tasks');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.home => const HomeScreen(),
        Routes.dailyTasks => const WeeklyTasksScreen(),
        Routes.weeklyTasks => const WeeklyTasksScreen(),
      };
}
