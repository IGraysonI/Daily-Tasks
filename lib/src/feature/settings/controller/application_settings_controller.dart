import 'package:control/control.dart';
import 'package:daily_tasks/src/feature/settings/controller/application_settings_state.dart';
import 'package:daily_tasks/src/feature/settings/data/application_settings_repository.dart';
import 'package:daily_tasks/src/feature/settings/model/application_settings.dart';

/// {@template application_settings_controller}
/// A [Controller] that manages the application settings.
/// {@endtemplate}
final class ApplicationSettingsController extends StateController<ApplicationSettingsState>
    with DroppableControllerHandler {
  /// {@macro application_settings_controller}
  ApplicationSettingsController({
    required ApplicationSettingsRepository applicaitonSettingsRepository,
    required super.initialState,
  }) : _applicationSettingsRepository = applicaitonSettingsRepository;

  final ApplicationSettingsRepository _applicationSettingsRepository;

  /// Sets the new application settings.
  void updateApplicationSettings({required ApplicationSettings applicationSettings}) => handle(
        () async {
          setState(
            ApplicationSettingsState.processing(
              applicationSettings: state.applicationSettings,
              message: 'Updating theme',
            ),
          );
          await _applicationSettingsRepository.setApplicationSettings(applicationSettings);
        },
        error: (error, _) async => setState(
          ApplicationSettingsState.error(
            applicationSettings: state.applicationSettings,
            error: error,
            message: 'Failed to update theme',
          ),
        ),
        done: () async => setState(
          ApplicationSettingsState.idle(
            applicationSettings: applicationSettings,
            message: 'Theme updated',
          ),
        ),
      );
}
