import 'package:daily_tasks/src/core/utils/layout/window_size.dart';
import 'package:flutter/widgets.dart';

/// {@template responsive_builder}
/// Widget for building different widgets based on the screen size.
/// {@endtemplate}
class ResponsiveBuilder extends StatelessWidget {
  /// {@macro responsive_builder}
  const ResponsiveBuilder({
    required this.builder,
    this.orElse,
    super.key, // ignore: unused_element
  });

  /// A builder function that provides widgets for each window size and orientation.
  final Widget Function(
    BuildContext context,
    WindowSize windowSize,
    Orientation orientation,
  ) builder;

  /// A fallback widget to use if no specific size is matched.
  final Widget? orElse;

  @override
  Widget build(BuildContext context) {
    // Get the current window size and orientation
    final windowSize = WindowSizeScope.of(context);
    final orientation = MediaQuery.of(context).orientation;
    return builder(context, windowSize, orientation);
  }
}
