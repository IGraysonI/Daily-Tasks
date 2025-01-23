import 'package:app_database/src/base/base_schema.dart';
import 'package:app_database/src/base/drift_provider.dart';
import 'package:app_database/src/dao/base/base_dao.dart';
import 'package:app_database/src/dao/base/basic_dao.dart';
import 'package:app_database/src/dao/base/dao_register.dart';
import 'package:drift/drift.dart';
import 'package:l/l.dart';

/// {@template dao_decorator_mixin}
/// Decorator for dao objects
/// {@endtemplate}
mixin DaoDecoratorMixin<D extends GeneratedDatabase> on DriftProvider<D> {
  /// For tracking execution,
  /// [callTracing] sign of inclusion, exclusion
  void callTrace<T>(
    String trace, {
    required Type? daoType,
    Type? runtimeType,
  }) {
    if (callTracing) {
      final str = '''--- [$D][TRACE] $trace | ${runtimeType ?? T} | ${daoType != null ? ' $daoType' : ''}''';
      l.v5(str);
    }
  }

  /// Get dao from register
  BasicDao<BaseSchema, DataClass, void> daoRuntime(Type type) => DaoRegister.instance.getDao(type);

  /// Get dao from register, from the list of daos by type
  T getDao<T extends IBaseDao>() => DaoRegister.instance.getDaoWhereType<T>();

  /// Add [dataClass]
  Future<int> insertData(Insertable<DataClass> dataClass) {
    final dao = daoRuntime(dataClass.runtimeType);
    callTrace<void>(
      'insertData',
      runtimeType: dataClass.runtimeType,
      daoType: dao.runtimeType,
    );
    return daoRuntime(dataClass.runtimeType).insertData(dataClass);
  }

  /// Add [dataClass] and return the record as [DataClass]
  Future<T> insertDataWithReturn<T extends DataClass>(
    Insertable<T> dataClass,
  ) async {
    final dao = daoRuntime(dataClass.runtimeType);
    callTrace<T>(
      'insertDataWithReturn',
      daoType: dao.runtimeType,
    );
    final result = await dao.insertWithReturn(dataClass);
    return result as T;
  }

  /// Find the required Data by [id]
  /// [T] - the type of the required Data class
  Future<T?> getData<T extends DataClass>(String id) async {
    final dao = daoRuntime(T);
    callTrace<T>('getData', daoType: dao.runtimeType);
    final result = await dao.selectData(id);
    return result as T?;
  }

  /// Get all [DataClass] from the database
  Future<List<T>?> getAllData<T extends DataClass>({List<String>? ids}) async {
    final dao = daoRuntime(T);
    callTrace<T>('getAllData', daoType: dao.runtimeType);
    final result = await daoRuntime(T).selectAllData(ids: ids);
    return result?.map((e) => e as T).toList();
  }

  /// Update data with [dataClass]
  Future<bool> updateData(Insertable<DataClass> dataClass) {
    final dao = daoRuntime(dataClass.runtimeType);
    callTrace<void>(
      'updateData',
      runtimeType: dataClass.runtimeType,
      daoType: dao.runtimeType,
    );
    return dao.updateData(dataClass);
  }

  /// Add [dataClass] in case of conflict, update where PK==dataclass.PK
  Future<int> upsertData(Insertable<DataClass> dataClass) async {
    final dao = daoRuntime(dataClass.runtimeType);
    callTrace<void>(
      'upsertData',
      runtimeType: dataClass.runtimeType,
      daoType: dao.runtimeType,
    );
    return dao.upsertData(dataClass);
  }

  /// Delete [dataClass] from the database
  Future<int> deleteData(DataClass dataClass) async {
    final dao = daoRuntime(dataClass.runtimeType);
    callTrace<void>(
      'deleteData',
      runtimeType: dataClass.runtimeType,
      daoType: dao.runtimeType,
    );
    return dao.deleteData(dataClass);
  }

  /// Add row of [DataClass], or replace
  Future<void> insertAllData(List<Insertable<DataClass>> rows) async {
    if (rows.isEmpty) return Future.value();
    final dao = daoRuntime(rows.first.runtimeType);
    callTrace<void>(
      'insertAllData',
      runtimeType: rows.first.runtimeType,
      daoType: dao.runtimeType,
    );
    await daoRuntime(rows.first.runtimeType).insertAll(rows);
  }

  /// Perform a transactional action with drift db using
  /// internal transaction api [transaction]
  Future<T> dbTransaction<T>(Future<T> Function() action) async {
    final stopwatch = Stopwatch()..start();
    callTrace<T>(' START dbTransaction', daoType: null);
    final result = await transaction(action);
    callTrace<T>(
      ' END dbTransaction ${stopwatch.elapsed.inMilliseconds} ms.',
      daoType: null,
    );
    stopwatch.stop();
    return result;
  }
}
