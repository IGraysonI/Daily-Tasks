import 'package:app_database/src/base/base_schema.dart';
import 'package:drift/drift.dart';

/// {@template base_dao}
/// CRUD interface for dao
/// [TableType] - Table with which the Dao works
/// [DataType] - The type with which the Dao works
/// {@endtemplate}
abstract interface class IBaseDao<TableType extends BaseSchema, DataType extends DataClass> {
  /// Returns [TableType] with which this Dao works
  Table get daoOnTable;

  /// Get a single instance of [DataType] from the [TableType] table by id||guid
  Future<DataClass?> selectData(String id);

  /// Insert [rows] records into the [TableType] table,
  Future<void> insertAll(List<Insertable<DataType>> rows);

  /// Get a list of [DataType] from the [TableType] table
  Future<List<DataClass>?> selectAllData();

  /// Delete an instance of [DataType] from the [TableType] table
  Future<int> deleteData(DataType data);

  /// Insert or update the instance of [DataType] in the [TableType] table in case of conflict
  Future<int> upsertData(Insertable<DataType> data);

  /// Insert an instance of [DataType] into the [TableType] table
  Future<int> insertData(Insertable<DataType> data);

  /// Update an instance of [DataType] in the [TableType] table
  Future<bool> updateData(Insertable<DataType> data);

  /// Insert an instance of [DataType] into the [TableType] table and return the record as [DataClass]
  Future<DataClass> insertWithReturn(Insertable<DataType> data);
}
