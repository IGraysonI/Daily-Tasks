// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DailyTasksTable extends DailyTasks
    with TableInfo<$DailyTasksTable, DailyTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, weight, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'DailyTasks';
  @override
  VerificationContext validateIntegrity(Insertable<DailyTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTask(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $DailyTasksTable createAlias(String alias) {
    return $DailyTasksTable(attachedDatabase, alias);
  }
}

class DailyTask extends BaseDataClass implements Insertable<DailyTask> {
  /// Id for row in table, by default created as UUID
  final String? id;

  /// Title of the task
  final String title;

  /// Description of the task
  final String? description;

  /// Weight of the task
  final int weight;

  /// Is the task completed
  final bool isCompleted;
  DailyTask(
      {this.id,
      required this.title,
      this.description,
      required this.weight,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['weight'] = Variable<int>(weight);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  DailyTasksCompanion toCompanion(bool nullToAbsent) {
    return DailyTasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      weight: Value(weight),
      isCompleted: Value(isCompleted),
    );
  }

  factory DailyTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTask(
      id: serializer.fromJson<String?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      weight: serializer.fromJson<int>(json['weight']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'weight': serializer.toJson<int>(weight),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  DailyTask copyWith(
          {Value<String?> id = const Value.absent(),
          String? title,
          Value<String?> description = const Value.absent(),
          int? weight,
          bool? isCompleted}) =>
      DailyTask(
        id: id.present ? id.value : this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        weight: weight ?? this.weight,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  DailyTask copyWithCompanion(DailyTasksCompanion data) {
    return DailyTask(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      weight: data.weight.present ? data.weight.value : this.weight,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyTask(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('weight: $weight, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, weight, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTask &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.weight == this.weight &&
          other.isCompleted == this.isCompleted);
}

class DailyTasksCompanion extends UpdateCompanion<DailyTask> {
  final Value<String?> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> weight;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const DailyTasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.weight = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyTasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required int weight,
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        weight = Value(weight);
  static Insertable<DailyTask> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? weight,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (weight != null) 'weight': weight,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyTasksCompanion copyWith(
      {Value<String?>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int>? weight,
      Value<bool>? isCompleted,
      Value<int>? rowid}) {
    return DailyTasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('weight: $weight, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyTasksTable dailyTasks = $DailyTasksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dailyTasks];
}

typedef $$DailyTasksTableCreateCompanionBuilder = DailyTasksCompanion Function({
  Value<String?> id,
  required String title,
  Value<String?> description,
  required int weight,
  Value<bool> isCompleted,
  Value<int> rowid,
});
typedef $$DailyTasksTableUpdateCompanionBuilder = DailyTasksCompanion Function({
  Value<String?> id,
  Value<String> title,
  Value<String?> description,
  Value<int> weight,
  Value<bool> isCompleted,
  Value<int> rowid,
});

class $$DailyTasksTableFilterComposer
    extends Composer<_$AppDatabase, $DailyTasksTable> {
  $$DailyTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));
}

class $$DailyTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyTasksTable> {
  $$DailyTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$DailyTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyTasksTable> {
  $$DailyTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);
}

class $$DailyTasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyTasksTable,
    DailyTask,
    $$DailyTasksTableFilterComposer,
    $$DailyTasksTableOrderingComposer,
    $$DailyTasksTableAnnotationComposer,
    $$DailyTasksTableCreateCompanionBuilder,
    $$DailyTasksTableUpdateCompanionBuilder,
    (DailyTask, BaseReferences<_$AppDatabase, $DailyTasksTable, DailyTask>),
    DailyTask,
    PrefetchHooks Function()> {
  $$DailyTasksTableTableManager(_$AppDatabase db, $DailyTasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> weight = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyTasksCompanion(
            id: id,
            title: title,
            description: description,
            weight: weight,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            required int weight,
            Value<bool> isCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyTasksCompanion.insert(
            id: id,
            title: title,
            description: description,
            weight: weight,
            isCompleted: isCompleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyTasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyTasksTable,
    DailyTask,
    $$DailyTasksTableFilterComposer,
    $$DailyTasksTableOrderingComposer,
    $$DailyTasksTableAnnotationComposer,
    $$DailyTasksTableCreateCompanionBuilder,
    $$DailyTasksTableUpdateCompanionBuilder,
    (DailyTask, BaseReferences<_$AppDatabase, $DailyTasksTable, DailyTask>),
    DailyTask,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyTasksTableTableManager get dailyTasks =>
      $$DailyTasksTableTableManager(_db, _db.dailyTasks);
}
