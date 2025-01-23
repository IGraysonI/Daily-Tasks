import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// {@template base_schema}
/// Base schema for all entities
/// {@endtemplate}
abstract class BaseSchema extends Table {
  /// Id for row in table, by default created as UUID
  TextColumn get id => text().nullable().clientDefault(const Uuid().v4)();

  @override
  Set<Column> get primaryKey => {id};
}

/// {@template base_schema}
/// Base class for all data classes
/// {@endtemplate}
abstract class BaseDataClass extends DataClass {
  /// Id for row in table, by default created as UUID
  abstract final String? id;

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
    };
  }
}
