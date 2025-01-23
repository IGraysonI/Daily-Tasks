import 'dart:async';

import 'package:app_database/src/base/base_schema.dart';
import 'package:app_database/src/dao/base/base_dao.dart';
import 'package:app_database/src/dao/base/dao_register.dart';
import 'package:drift/drift.dart';

/// {@template basic_dao}
/// Abstract implementation for DAO object,
/// Executes the [IBaseDao] contract, When creating a DAO object for a table
/// it is enough to pass [Database] and specify a getter for the table
///
/// ```dart
/// class CounterpartiesDao extends BasicDao<Counterparties, Counterparty, ConcreteDB> {
///   CounterpartiesDao(ConcreteDB sqlDatabase) : super(sqlDatabase);
///
///   @override
///   $CounterpartiesTable get daoOnTable => db.counterparties;
/// }
/// ```
/// further custom queries can be described in a specific dao
/// {@endtemplate}
abstract class BasicDao<TableType extends BaseSchema, DataType extends DataClass, Database extends GeneratedDatabase>
    extends DatabaseAccessor<Database> implements IBaseDao<TableType, DataType> {
  /// {@macro basic_dao}
  BasicDao(super.attachedDatabase) {
    /// Register the dao in the registry, each dao will call the super constructor
    /// and register itself in the registry
    DaoRegister.instance.register(DataType, this);
  }

  @override
  TableInfo<TableType, DataClass> get daoOnTable;

  @override
  Future<void> insertAll(List<Insertable<DataType>> rows) async => await batch((batch) async {
        if (rows.isEmpty) return;
        batch.insertAllOnConflictUpdate(daoOnTable, rows);
      });

  @override
  Future<int> deleteData(DataType data) async => delete(daoOnTable).delete(data as Insertable<DataType>);

  @override
  Future<int> insertData(Insertable<DataType> data) => into(daoOnTable).insert(data);

  @override
  Future<List<DataClass>?> selectAllData({List<String>? ids}) {
    final query = select(daoOnTable);
    if (ids != null) query.where((tbl) => tbl.id.isIn(ids));
    return query.get();
  }

  @override
  Future<DataClass?> selectData(String id) => (select(daoOnTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  @override
  Future<bool> updateData(Insertable<DataType> data) => update(daoOnTable).replace(data);

  @override
  Future<int> upsertData(Insertable<DataType> data) => into(daoOnTable).insertOnConflictUpdate(data);

  @override
  Future<DataClass> insertWithReturn(Insertable<DataType> data) =>
      into(daoOnTable).insertReturning(data, mode: InsertMode.insertOrReplace);
}
