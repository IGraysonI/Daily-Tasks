import 'package:daily_tasks/src/feature/home/widget/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

/// {@template routes}
/// Enum that contains all the routes of the application.
/// {@endtemplate}
enum Routes with OctopusRoute {
  /// Home route.
  home('home', title: 'Home');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.home => const HomeScreen(),
      };
}
