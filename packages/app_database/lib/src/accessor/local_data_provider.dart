import 'package:app_database/src/app_database.dart';
import 'package:app_database/src/base/dao_decorator_mixin.dart';
import 'package:app_database/src/base/drift_provider.dart';
import 'package:app_database/src/dao/base/base_dao.dart';
import 'package:app_database/src/dao/daos.dart';

/// {@template local_data_provider}
/// Local data provider for the drift database
/// {@endtemplate}
final class LocalDataProvider extends DriftProvider<AppDatabase> with DaoDecoratorMixin<AppDatabase> {
  /// Singleton
  ///
  /// [database] The drift database type [AppDatabase]
  /// [callTracing] tracing of dao decorator calls [DaoDecoratorMixin]
  factory LocalDataProvider(
    AppDatabase database, {
    bool callTracing = true,
  }) =>
      _instance ??= LocalDataProvider._(database, callTracing: callTracing);

  /// {@macro local_data_provider}
  LocalDataProvider._(
    super.attachedDatabase, {
    required super.callTracing,
  }) : super(
          daos: <IBaseDao>{
            DailyTasksDao(attachedDatabase),
          },
        );

  static LocalDataProvider? _instance;
}
