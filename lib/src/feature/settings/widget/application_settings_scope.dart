import 'package:control/control.dart';
import 'package:daily_tasks/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:daily_tasks/src/feature/settings/controller/application_settings_controller.dart';
import 'package:daily_tasks/src/feature/settings/controller/application_settings_state.dart';
import 'package:daily_tasks/src/feature/settings/model/application_settings.dart';
import 'package:flutter/widgets.dart';

/// {@template settings_scope}
/// SettingsScope widget.
/// {@endtemplate}
class ApplicationSettingsScope extends StatefulWidget {
  /// {@macro settings_scope}
  const ApplicationSettingsScope({required this.child, super.key});

  /// The child widget.
  final Widget child;

  /// Get the [ApplicationSettingsController] instance.
  static ApplicationSettingsController of(BuildContext context, {bool listen = true}) {
    final applicationSettingsScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
        : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return applicationSettingsScope!.state._applicationSettingsController;
  }

  /// Get the [ApplicationSettings] instance.
  static ApplicationSettings settingsOf(BuildContext context, {bool listen = true}) {
    final applicationSettingsScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
        : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return applicationSettingsScope!.settings ?? const ApplicationSettings();
  }

  @override
  State<ApplicationSettingsScope> createState() => _ApplicationSettingsScopeState();
}

/// State for widget SettingsScope.
class _ApplicationSettingsScopeState extends State<ApplicationSettingsScope> {
  late final ApplicationSettingsController _applicationSettingsController;

  @override
  void initState() {
    super.initState();
    _applicationSettingsController = DependenciesScope.of(context).applicationSettingsController;
  }

  @override
  Widget build(BuildContext context) => StateConsumer<ApplicationSettingsController, ApplicationSettingsState>(
        controller: _applicationSettingsController,
        builder: (context, state, child) => _InheritedSettings(
          settings: state.applicationSettings,
          state: this,
          child: widget.child,
        ),
      );
}

/// {@template inherited_settings}
/// _InheritedSettings widget.
/// {@endtemplate}
class _InheritedSettings extends InheritedWidget {
  /// {@macro inherited_settings}
  const _InheritedSettings({
    required super.child,
    required this.state,
    required this.settings,
    super.key, // ignore: unused_element
  });

  /// _SettingsScopeState instance.
  final _ApplicationSettingsScopeState state;
  final ApplicationSettings? settings;

  @override
  bool updateShouldNotify(covariant _InheritedSettings oldWidget) => settings != oldWidget.settings;
}
