import 'dart:io' as io;

import 'package:app_database/src/base/base_schema.dart';
import 'package:app_database/src/table/tables.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

export 'package:app_database/src/base/base_schema.dart';
export 'package:drift/drift.dart' hide Column, JsonKey;
export 'package:uuid/uuid.dart';

part 'app_database.g.dart';

const List<Type> _driftTables = <Type>[
  DailyTasks,
];

/// {@template app_database}
/// The drift-managed database configuration
/// {@endtemplate}
@DriftDatabase(tables: _driftTables)
class AppDatabase extends _$AppDatabase {
  /// {@macro app_database}
  AppDatabase(super.e);

  /// Open the database
  static Future<AppDatabase> openDatabase() async => AppDatabase(await _openConnection());

  /// Full database recreation, including deletion of the data itself
  Future<bool> dropDatabaseAndRecreate() async {
    // ignore: no_runtimetype_tostring
    l.i('Recreating the database $runtimeType');
    try {
      final migrator = Migrator(attachedDatabase);
      await _recreateDb(migrator);
    } on Exception catch (e, stackTrace) {
      l.e('Error recreating the database $e', stackTrace);
      return false;
    }
    return true;
  }

  Future<void> _recreateDb(Migrator m) async {
    for (final schemeEntity in attachedDatabase.allSchemaEntities) {
      l.w('${schemeEntity.entityName.padRight(48)} -> X');
      await m.drop(schemeEntity);
      await m.create(schemeEntity);
    }
  }

  @override
  int get schemaVersion => 1;
}

/// Open a connection to the database
Future<QueryExecutor> _openConnection() async {
  l.s('Opening database connection');

  final dbFolder = await getApplicationDocumentsDirectory();
  io.File file;
  file = io.File(p.join(dbFolder.path, 'db.sqlite'));
  return NativeDatabase.createInBackground(file, logStatements: kDebugMode);
}
