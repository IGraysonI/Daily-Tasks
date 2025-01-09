import 'package:daily_tasks/src/core/constant/localization/localization.dart';
import 'package:daily_tasks/src/core/router/router_state_mixin.dart';
import 'package:daily_tasks/src/feature/settings/model/application_theme.dart';
import 'package:daily_tasks/src/feature/settings/widget/application_settings_scope.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatefulWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey(debugLabel: 'MaterialContext');

  @override
  State<MaterialContext> createState() => _MaterialContextState();
}

class _MaterialContextState extends State<MaterialContext> with RouterStateMixin {
  @override
  Widget build(BuildContext context) {
    final settings = ApplicationSettingsScope.settingsOf(context);
    final mediaQueryData = MediaQuery.of(context);
    final theme = settings.applicationTheme ?? ApplicationTheme.defaultTheme;
    final lightTheme = theme.buildThemeData(Brightness.light);
    final darkTheme = theme.buildThemeData(Brightness.dark);
    final themeMode = theme.themeMode;
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: settings.locale,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      routerConfig: router.config,
      // home: const HomeScreen(),
      builder: (context, child) => MediaQuery(
        key: MaterialContext._globalKey,
        data: mediaQueryData.copyWith(
          textScaler: TextScaler.linear(
            mediaQueryData.textScaler.scale(settings.textScale ?? 1).clamp(0.5, 2),
          ),
        ),
        child: OctopusTools(
          child: child!,
        ),
      ),
    );
  }
}
