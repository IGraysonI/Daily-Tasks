import 'dart:async';

import 'package:daily_tasks/src/core/constant/application_config.dart';
import 'package:daily_tasks/src/core/utils/logger/logger.dart';
import 'package:daily_tasks/src/core/utils/logger/printing_log_observer.dart';
import 'package:daily_tasks/src/feature/initialization/logic/composition_root.dart';
import 'package:daily_tasks/src/feature/initialization/widget/initialization_failed_app.dart';
import 'package:daily_tasks/src/feature/initialization/widget/root_context.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// {@template application_runner}
/// A class that is responsible for running the application.
/// {@endtemplate}
sealed class ApplicationRunner {
  /// {@macro application_runner}
  const ApplicationRunner._();

  /// Initializes dependencies and launches the application within a guarded execution zone.
  static Future<void> startup() async {
    const config = ApplicationConfig();
    // final errorReporter = await const ErrorReporterFactory(config).create();
    final logger = const ApplicationLoggerFactory(
      observers: [
        // ErrorReporterLogObserver(errorReporter),
        if (!kReleaseMode) PrintingLogObserver(logLevel: LogLevel.trace),
      ],
    ).create();
    await runZonedGuarded(
      () async {
        // Ensure Flutter is initialized
        WidgetsFlutterBinding.ensureInitialized();

        // Configure global error interception
        FlutterError.onError = logger.logFlutterError;
        WidgetsBinding.instance.platformDispatcher.onError = logger.logPlatformDispatcherError;

        // TODO: Add controller observer
        // Setup bloc observer and transformer
        // Bloc.observer = AppBlocObserver(logger);
        // Bloc.transformer = SequentialBlocTransformer().transform;

        Future<void> launchApplication() async {
          try {
            final compositionResult = await CompositionRoot(
              config: config,
              logger: logger,
            ).compose();
            runApp(RootContext(compositionResult: compositionResult));
          } on Object catch (e, stackTrace) {
            logger.error('Initialization failed', error: e, stackTrace: stackTrace);
            runApp(
              InitializationFailedApp(
                error: e,
                stackTrace: stackTrace,
                onRetryInitialization: launchApplication,
              ),
            );
          }
        }

        // Launch the application
        await launchApplication();
      },
      logger.logZoneError,
    );
  }
}
