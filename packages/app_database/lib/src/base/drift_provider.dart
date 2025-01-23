import 'package:app_database/src/dao/base/base_dao.dart';
import 'package:drift/drift.dart';

/// {@template drift_provider}
/// Provides a [DatabaseAccessor] for a [GeneratedDatabase] with a set of [IBaseDao]
/// {@endtemplate}
abstract class DriftProvider<D extends GeneratedDatabase> extends DatabaseAccessor<D> {
  /// {@macro drift_provider}
  DriftProvider(
    super.attachedDatabase, {
    required this.daos,
    this.callTracing = false,
  }) : assert(
          () {
            final tablesCount = attachedDatabase.allTables.length;
            final dataDaoMapLength = daos.length;
            final tableSet = attachedDatabase.allTables.map<String>((e) => e.actualTableName).toSet();
            // ignore: invalid_use_of_visible_for_overriding_member
            final dataDaoMapTableSet = daos.map<String>((e) => e.daoOnTable.tableName!).toSet();
            final diff = tableSet.difference(dataDaoMapTableSet);
            assert(
              daos.length == attachedDatabase.allTables.length,
              'for Database $D _dataDaoMap should contains same length as count of tables in '
              'application, now tables in _dataDaoMap: $dataDaoMapLength '
              'should be: $tablesCount\n'
              'Make sure you fill all DataClass types in _dataDaoMap, and pass '
              'corresponding DaoObject\n'
              'list of missing tables in _dataDaoMap: '
              '${StringBuffer()..writeAll(diff, '\n')}',
            );
            return true;
          }(),
          'DriftProvider assert',
        );

  /// Set of [IBaseDao] for [D]
  late final Set<IBaseDao> daos;

  /// Tracing of calls to the dao decorator
  final bool callTracing;
}
