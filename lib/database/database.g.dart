// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ChecklistItemsTable extends ChecklistItems
    with TableInfo<$ChecklistItemsTable, ChecklistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _metaMeta = const VerificationMeta('meta');
  @override
  late final GeneratedColumn<String> meta = GeneratedColumn<String>(
      'meta', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<int> done = GeneratedColumn<int>(
      'done', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, category, title, meta, tag, done];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_items';
  @override
  VerificationContext validateIntegrity(Insertable<ChecklistItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('meta')) {
      context.handle(
          _metaMeta, meta.isAcceptableOrUnknown(data['meta']!, _metaMeta));
    } else if (isInserting) {
      context.missing(_metaMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('done')) {
      context.handle(
          _doneMeta, done.isAcceptableOrUnknown(data['done']!, _doneMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      meta: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meta'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
      done: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}done'])!,
    );
  }

  @override
  $ChecklistItemsTable createAlias(String alias) {
    return $ChecklistItemsTable(attachedDatabase, alias);
  }
}

class ChecklistItem extends DataClass implements Insertable<ChecklistItem> {
  final String id;
  final String category;
  final String title;
  final String meta;
  final String tag;
  final int done;
  const ChecklistItem(
      {required this.id,
      required this.category,
      required this.title,
      required this.meta,
      required this.tag,
      required this.done});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    map['title'] = Variable<String>(title);
    map['meta'] = Variable<String>(meta);
    map['tag'] = Variable<String>(tag);
    map['done'] = Variable<int>(done);
    return map;
  }

  ChecklistItemsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistItemsCompanion(
      id: Value(id),
      category: Value(category),
      title: Value(title),
      meta: Value(meta),
      tag: Value(tag),
      done: Value(done),
    );
  }

  factory ChecklistItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistItem(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      title: serializer.fromJson<String>(json['title']),
      meta: serializer.fromJson<String>(json['meta']),
      tag: serializer.fromJson<String>(json['tag']),
      done: serializer.fromJson<int>(json['done']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'title': serializer.toJson<String>(title),
      'meta': serializer.toJson<String>(meta),
      'tag': serializer.toJson<String>(tag),
      'done': serializer.toJson<int>(done),
    };
  }

  ChecklistItem copyWith(
          {String? id,
          String? category,
          String? title,
          String? meta,
          String? tag,
          int? done}) =>
      ChecklistItem(
        id: id ?? this.id,
        category: category ?? this.category,
        title: title ?? this.title,
        meta: meta ?? this.meta,
        tag: tag ?? this.tag,
        done: done ?? this.done,
      );
  ChecklistItem copyWithCompanion(ChecklistItemsCompanion data) {
    return ChecklistItem(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      title: data.title.present ? data.title.value : this.title,
      meta: data.meta.present ? data.meta.value : this.meta,
      tag: data.tag.present ? data.tag.value : this.tag,
      done: data.done.present ? data.done.value : this.done,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItem(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('meta: $meta, ')
          ..write('tag: $tag, ')
          ..write('done: $done')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, title, meta, tag, done);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistItem &&
          other.id == this.id &&
          other.category == this.category &&
          other.title == this.title &&
          other.meta == this.meta &&
          other.tag == this.tag &&
          other.done == this.done);
}

class ChecklistItemsCompanion extends UpdateCompanion<ChecklistItem> {
  final Value<String> id;
  final Value<String> category;
  final Value<String> title;
  final Value<String> meta;
  final Value<String> tag;
  final Value<int> done;
  final Value<int> rowid;
  const ChecklistItemsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.meta = const Value.absent(),
    this.tag = const Value.absent(),
    this.done = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistItemsCompanion.insert({
    required String id,
    required String category,
    required String title,
    required String meta,
    this.tag = const Value.absent(),
    this.done = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        title = Value(title),
        meta = Value(meta);
  static Insertable<ChecklistItem> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? title,
    Expression<String>? meta,
    Expression<String>? tag,
    Expression<int>? done,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (meta != null) 'meta': meta,
      if (tag != null) 'tag': tag,
      if (done != null) 'done': done,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? category,
      Value<String>? title,
      Value<String>? meta,
      Value<String>? tag,
      Value<int>? done,
      Value<int>? rowid}) {
    return ChecklistItemsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      meta: meta ?? this.meta,
      tag: tag ?? this.tag,
      done: done ?? this.done,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (meta.present) {
      map['meta'] = Variable<String>(meta.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (done.present) {
      map['done'] = Variable<int>(done.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItemsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('meta: $meta, ')
          ..write('tag: $tag, ')
          ..write('done: $done, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MilestonesTable extends Milestones
    with TableInfo<$MilestonesTable, Milestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkedIdsMeta =
      const VerificationMeta('linkedIds');
  @override
  late final GeneratedColumn<String> linkedIds = GeneratedColumn<String>(
      'linked_ids', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<int> done = GeneratedColumn<int>(
      'done', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, date, status, linkedIds, done];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'milestones';
  @override
  VerificationContext validateIntegrity(Insertable<Milestone> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('linked_ids')) {
      context.handle(_linkedIdsMeta,
          linkedIds.isAcceptableOrUnknown(data['linked_ids']!, _linkedIdsMeta));
    }
    if (data.containsKey('done')) {
      context.handle(
          _doneMeta, done.isAcceptableOrUnknown(data['done']!, _doneMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Milestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Milestone(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      linkedIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}linked_ids'])!,
      done: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}done'])!,
    );
  }

  @override
  $MilestonesTable createAlias(String alias) {
    return $MilestonesTable(attachedDatabase, alias);
  }
}

class Milestone extends DataClass implements Insertable<Milestone> {
  final String id;
  final String title;
  final String description;
  final String date;
  final String status;
  final String linkedIds;
  final int done;
  const Milestone(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.status,
      required this.linkedIds,
      required this.done});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<String>(date);
    map['status'] = Variable<String>(status);
    map['linked_ids'] = Variable<String>(linkedIds);
    map['done'] = Variable<int>(done);
    return map;
  }

  MilestonesCompanion toCompanion(bool nullToAbsent) {
    return MilestonesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      date: Value(date),
      status: Value(status),
      linkedIds: Value(linkedIds),
      done: Value(done),
    );
  }

  factory Milestone.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Milestone(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      linkedIds: serializer.fromJson<String>(json['linkedIds']),
      done: serializer.fromJson<int>(json['done']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'linkedIds': serializer.toJson<String>(linkedIds),
      'done': serializer.toJson<int>(done),
    };
  }

  Milestone copyWith(
          {String? id,
          String? title,
          String? description,
          String? date,
          String? status,
          String? linkedIds,
          int? done}) =>
      Milestone(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        status: status ?? this.status,
        linkedIds: linkedIds ?? this.linkedIds,
        done: done ?? this.done,
      );
  Milestone copyWithCompanion(MilestonesCompanion data) {
    return Milestone(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      linkedIds: data.linkedIds.present ? data.linkedIds.value : this.linkedIds,
      done: data.done.present ? data.done.value : this.done,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Milestone(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('linkedIds: $linkedIds, ')
          ..write('done: $done')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, date, status, linkedIds, done);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Milestone &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.date == this.date &&
          other.status == this.status &&
          other.linkedIds == this.linkedIds &&
          other.done == this.done);
}

class MilestonesCompanion extends UpdateCompanion<Milestone> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> date;
  final Value<String> status;
  final Value<String> linkedIds;
  final Value<int> done;
  final Value<int> rowid;
  const MilestonesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.linkedIds = const Value.absent(),
    this.done = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MilestonesCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String date,
    required String status,
    this.linkedIds = const Value.absent(),
    this.done = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        description = Value(description),
        date = Value(date),
        status = Value(status);
  static Insertable<Milestone> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? date,
    Expression<String>? status,
    Expression<String>? linkedIds,
    Expression<int>? done,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (linkedIds != null) 'linked_ids': linkedIds,
      if (done != null) 'done': done,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MilestonesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String>? date,
      Value<String>? status,
      Value<String>? linkedIds,
      Value<int>? done,
      Value<int>? rowid}) {
    return MilestonesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
      linkedIds: linkedIds ?? this.linkedIds,
      done: done ?? this.done,
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
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (linkedIds.present) {
      map['linked_ids'] = Variable<String>(linkedIds.value);
    }
    if (done.present) {
      map['done'] = Variable<int>(done.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MilestonesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('linkedIds: $linkedIds, ')
          ..write('done: $done, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RequirementsTable extends Requirements
    with TableInfo<$RequirementsTable, Requirement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RequirementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('todo'));
  @override
  List<GeneratedColumn> get $columns => [id, groupName, name, note, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'requirements';
  @override
  VerificationContext validateIntegrity(Insertable<Requirement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Requirement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Requirement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $RequirementsTable createAlias(String alias) {
    return $RequirementsTable(attachedDatabase, alias);
  }
}

class Requirement extends DataClass implements Insertable<Requirement> {
  final String id;
  final String groupName;
  final String name;
  final String note;
  final String status;
  const Requirement(
      {required this.id,
      required this.groupName,
      required this.name,
      required this.note,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_name'] = Variable<String>(groupName);
    map['name'] = Variable<String>(name);
    map['note'] = Variable<String>(note);
    map['status'] = Variable<String>(status);
    return map;
  }

  RequirementsCompanion toCompanion(bool nullToAbsent) {
    return RequirementsCompanion(
      id: Value(id),
      groupName: Value(groupName),
      name: Value(name),
      note: Value(note),
      status: Value(status),
    );
  }

  factory Requirement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Requirement(
      id: serializer.fromJson<String>(json['id']),
      groupName: serializer.fromJson<String>(json['groupName']),
      name: serializer.fromJson<String>(json['name']),
      note: serializer.fromJson<String>(json['note']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupName': serializer.toJson<String>(groupName),
      'name': serializer.toJson<String>(name),
      'note': serializer.toJson<String>(note),
      'status': serializer.toJson<String>(status),
    };
  }

  Requirement copyWith(
          {String? id,
          String? groupName,
          String? name,
          String? note,
          String? status}) =>
      Requirement(
        id: id ?? this.id,
        groupName: groupName ?? this.groupName,
        name: name ?? this.name,
        note: note ?? this.note,
        status: status ?? this.status,
      );
  Requirement copyWithCompanion(RequirementsCompanion data) {
    return Requirement(
      id: data.id.present ? data.id.value : this.id,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      name: data.name.present ? data.name.value : this.name,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Requirement(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('name: $name, ')
          ..write('note: $note, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupName, name, note, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Requirement &&
          other.id == this.id &&
          other.groupName == this.groupName &&
          other.name == this.name &&
          other.note == this.note &&
          other.status == this.status);
}

class RequirementsCompanion extends UpdateCompanion<Requirement> {
  final Value<String> id;
  final Value<String> groupName;
  final Value<String> name;
  final Value<String> note;
  final Value<String> status;
  final Value<int> rowid;
  const RequirementsCompanion({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.name = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RequirementsCompanion.insert({
    required String id,
    required String groupName,
    required String name,
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupName = Value(groupName),
        name = Value(name);
  static Insertable<Requirement> custom({
    Expression<String>? id,
    Expression<String>? groupName,
    Expression<String>? name,
    Expression<String>? note,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupName != null) 'group_name': groupName,
      if (name != null) 'name': name,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RequirementsCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupName,
      Value<String>? name,
      Value<String>? note,
      Value<String>? status,
      Value<int>? rowid}) {
    return RequirementsCompanion(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      name: name ?? this.name,
      note: note ?? this.note,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RequirementsCompanion(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('name: $name, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RunnerFeaturesTable extends RunnerFeatures
    with TableInfo<$RunnerFeaturesTable, RunnerFeature> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RunnerFeaturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('todo'));
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<int> done = GeneratedColumn<int>(
      'done', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, icon, color, status, done];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'runner_features';
  @override
  VerificationContext validateIntegrity(Insertable<RunnerFeature> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('done')) {
      context.handle(
          _doneMeta, done.isAcceptableOrUnknown(data['done']!, _doneMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RunnerFeature map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RunnerFeature(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      done: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}done'])!,
    );
  }

  @override
  $RunnerFeaturesTable createAlias(String alias) {
    return $RunnerFeaturesTable(attachedDatabase, alias);
  }
}

class RunnerFeature extends DataClass implements Insertable<RunnerFeature> {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String color;
  final String status;
  final int done;
  const RunnerFeature(
      {required this.id,
      required this.title,
      required this.description,
      required this.icon,
      required this.color,
      required this.status,
      required this.done});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<String>(color);
    map['status'] = Variable<String>(status);
    map['done'] = Variable<int>(done);
    return map;
  }

  RunnerFeaturesCompanion toCompanion(bool nullToAbsent) {
    return RunnerFeaturesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      icon: Value(icon),
      color: Value(color),
      status: Value(status),
      done: Value(done),
    );
  }

  factory RunnerFeature.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RunnerFeature(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<String>(json['color']),
      status: serializer.fromJson<String>(json['status']),
      done: serializer.fromJson<int>(json['done']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<String>(color),
      'status': serializer.toJson<String>(status),
      'done': serializer.toJson<int>(done),
    };
  }

  RunnerFeature copyWith(
          {String? id,
          String? title,
          String? description,
          String? icon,
          String? color,
          String? status,
          int? done}) =>
      RunnerFeature(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        status: status ?? this.status,
        done: done ?? this.done,
      );
  RunnerFeature copyWithCompanion(RunnerFeaturesCompanion data) {
    return RunnerFeature(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      status: data.status.present ? data.status.value : this.status,
      done: data.done.present ? data.done.value : this.done,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RunnerFeature(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('status: $status, ')
          ..write('done: $done')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, icon, color, status, done);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RunnerFeature &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.status == this.status &&
          other.done == this.done);
}

class RunnerFeaturesCompanion extends UpdateCompanion<RunnerFeature> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> icon;
  final Value<String> color;
  final Value<String> status;
  final Value<int> done;
  final Value<int> rowid;
  const RunnerFeaturesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.status = const Value.absent(),
    this.done = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RunnerFeaturesCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String icon,
    required String color,
    this.status = const Value.absent(),
    this.done = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        description = Value(description),
        icon = Value(icon),
        color = Value(color);
  static Insertable<RunnerFeature> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<String>? status,
    Expression<int>? done,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (status != null) 'status': status,
      if (done != null) 'done': done,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RunnerFeaturesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String>? icon,
      Value<String>? color,
      Value<String>? status,
      Value<int>? done,
      Value<int>? rowid}) {
    return RunnerFeaturesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      status: status ?? this.status,
      done: done ?? this.done,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (done.present) {
      map['done'] = Variable<int>(done.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RunnerFeaturesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('status: $status, ')
          ..write('done: $done, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
  late final $MilestonesTable milestones = $MilestonesTable(this);
  late final $RequirementsTable requirements = $RequirementsTable(this);
  late final $RunnerFeaturesTable runnerFeatures = $RunnerFeaturesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [checklistItems, milestones, requirements, runnerFeatures];
}

typedef $$ChecklistItemsTableCreateCompanionBuilder = ChecklistItemsCompanion
    Function({
  required String id,
  required String category,
  required String title,
  required String meta,
  Value<String> tag,
  Value<int> done,
  Value<int> rowid,
});
typedef $$ChecklistItemsTableUpdateCompanionBuilder = ChecklistItemsCompanion
    Function({
  Value<String> id,
  Value<String> category,
  Value<String> title,
  Value<String> meta,
  Value<String> tag,
  Value<int> done,
  Value<int> rowid,
});

class $$ChecklistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meta => $composableBuilder(
      column: $table.meta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnFilters(column));
}

class $$ChecklistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meta => $composableBuilder(
      column: $table.meta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnOrderings(column));
}

class $$ChecklistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get meta =>
      $composableBuilder(column: $table.meta, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<int> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);
}

class $$ChecklistItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChecklistItemsTable,
    ChecklistItem,
    $$ChecklistItemsTableFilterComposer,
    $$ChecklistItemsTableOrderingComposer,
    $$ChecklistItemsTableAnnotationComposer,
    $$ChecklistItemsTableCreateCompanionBuilder,
    $$ChecklistItemsTableUpdateCompanionBuilder,
    (
      ChecklistItem,
      BaseReferences<_$AppDatabase, $ChecklistItemsTable, ChecklistItem>
    ),
    ChecklistItem,
    PrefetchHooks Function()> {
  $$ChecklistItemsTableTableManager(
      _$AppDatabase db, $ChecklistItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> meta = const Value.absent(),
            Value<String> tag = const Value.absent(),
            Value<int> done = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChecklistItemsCompanion(
            id: id,
            category: category,
            title: title,
            meta: meta,
            tag: tag,
            done: done,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String category,
            required String title,
            required String meta,
            Value<String> tag = const Value.absent(),
            Value<int> done = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChecklistItemsCompanion.insert(
            id: id,
            category: category,
            title: title,
            meta: meta,
            tag: tag,
            done: done,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChecklistItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChecklistItemsTable,
    ChecklistItem,
    $$ChecklistItemsTableFilterComposer,
    $$ChecklistItemsTableOrderingComposer,
    $$ChecklistItemsTableAnnotationComposer,
    $$ChecklistItemsTableCreateCompanionBuilder,
    $$ChecklistItemsTableUpdateCompanionBuilder,
    (
      ChecklistItem,
      BaseReferences<_$AppDatabase, $ChecklistItemsTable, ChecklistItem>
    ),
    ChecklistItem,
    PrefetchHooks Function()>;
typedef $$MilestonesTableCreateCompanionBuilder = MilestonesCompanion Function({
  required String id,
  required String title,
  required String description,
  required String date,
  required String status,
  Value<String> linkedIds,
  Value<int> done,
  Value<int> rowid,
});
typedef $$MilestonesTableUpdateCompanionBuilder = MilestonesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<String> date,
  Value<String> status,
  Value<String> linkedIds,
  Value<int> done,
  Value<int> rowid,
});

class $$MilestonesTableFilterComposer
    extends Composer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableFilterComposer({
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

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedIds => $composableBuilder(
      column: $table.linkedIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnFilters(column));
}

class $$MilestonesTableOrderingComposer
    extends Composer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableOrderingComposer({
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

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedIds => $composableBuilder(
      column: $table.linkedIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnOrderings(column));
}

class $$MilestonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableAnnotationComposer({
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

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get linkedIds =>
      $composableBuilder(column: $table.linkedIds, builder: (column) => column);

  GeneratedColumn<int> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);
}

class $$MilestonesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MilestonesTable,
    Milestone,
    $$MilestonesTableFilterComposer,
    $$MilestonesTableOrderingComposer,
    $$MilestonesTableAnnotationComposer,
    $$MilestonesTableCreateCompanionBuilder,
    $$MilestonesTableUpdateCompanionBuilder,
    (Milestone, BaseReferences<_$AppDatabase, $MilestonesTable, Milestone>),
    Milestone,
    PrefetchHooks Function()> {
  $$MilestonesTableTableManager(_$AppDatabase db, $MilestonesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MilestonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MilestonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MilestonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> linkedIds = const Value.absent(),
            Value<int> done = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MilestonesCompanion(
            id: id,
            title: title,
            description: description,
            date: date,
            status: status,
            linkedIds: linkedIds,
            done: done,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String description,
            required String date,
            required String status,
            Value<String> linkedIds = const Value.absent(),
            Value<int> done = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MilestonesCompanion.insert(
            id: id,
            title: title,
            description: description,
            date: date,
            status: status,
            linkedIds: linkedIds,
            done: done,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MilestonesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MilestonesTable,
    Milestone,
    $$MilestonesTableFilterComposer,
    $$MilestonesTableOrderingComposer,
    $$MilestonesTableAnnotationComposer,
    $$MilestonesTableCreateCompanionBuilder,
    $$MilestonesTableUpdateCompanionBuilder,
    (Milestone, BaseReferences<_$AppDatabase, $MilestonesTable, Milestone>),
    Milestone,
    PrefetchHooks Function()>;
typedef $$RequirementsTableCreateCompanionBuilder = RequirementsCompanion
    Function({
  required String id,
  required String groupName,
  required String name,
  Value<String> note,
  Value<String> status,
  Value<int> rowid,
});
typedef $$RequirementsTableUpdateCompanionBuilder = RequirementsCompanion
    Function({
  Value<String> id,
  Value<String> groupName,
  Value<String> name,
  Value<String> note,
  Value<String> status,
  Value<int> rowid,
});

class $$RequirementsTableFilterComposer
    extends Composer<_$AppDatabase, $RequirementsTable> {
  $$RequirementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$RequirementsTableOrderingComposer
    extends Composer<_$AppDatabase, $RequirementsTable> {
  $$RequirementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$RequirementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RequirementsTable> {
  $$RequirementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$RequirementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RequirementsTable,
    Requirement,
    $$RequirementsTableFilterComposer,
    $$RequirementsTableOrderingComposer,
    $$RequirementsTableAnnotationComposer,
    $$RequirementsTableCreateCompanionBuilder,
    $$RequirementsTableUpdateCompanionBuilder,
    (
      Requirement,
      BaseReferences<_$AppDatabase, $RequirementsTable, Requirement>
    ),
    Requirement,
    PrefetchHooks Function()> {
  $$RequirementsTableTableManager(_$AppDatabase db, $RequirementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RequirementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RequirementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RequirementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> note = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RequirementsCompanion(
            id: id,
            groupName: groupName,
            name: name,
            note: note,
            status: status,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupName,
            required String name,
            Value<String> note = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RequirementsCompanion.insert(
            id: id,
            groupName: groupName,
            name: name,
            note: note,
            status: status,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RequirementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RequirementsTable,
    Requirement,
    $$RequirementsTableFilterComposer,
    $$RequirementsTableOrderingComposer,
    $$RequirementsTableAnnotationComposer,
    $$RequirementsTableCreateCompanionBuilder,
    $$RequirementsTableUpdateCompanionBuilder,
    (
      Requirement,
      BaseReferences<_$AppDatabase, $RequirementsTable, Requirement>
    ),
    Requirement,
    PrefetchHooks Function()>;
typedef $$RunnerFeaturesTableCreateCompanionBuilder = RunnerFeaturesCompanion
    Function({
  required String id,
  required String title,
  required String description,
  required String icon,
  required String color,
  Value<String> status,
  Value<int> done,
  Value<int> rowid,
});
typedef $$RunnerFeaturesTableUpdateCompanionBuilder = RunnerFeaturesCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<String> icon,
  Value<String> color,
  Value<String> status,
  Value<int> done,
  Value<int> rowid,
});

class $$RunnerFeaturesTableFilterComposer
    extends Composer<_$AppDatabase, $RunnerFeaturesTable> {
  $$RunnerFeaturesTableFilterComposer({
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

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnFilters(column));
}

class $$RunnerFeaturesTableOrderingComposer
    extends Composer<_$AppDatabase, $RunnerFeaturesTable> {
  $$RunnerFeaturesTableOrderingComposer({
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

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnOrderings(column));
}

class $$RunnerFeaturesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RunnerFeaturesTable> {
  $$RunnerFeaturesTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);
}

class $$RunnerFeaturesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RunnerFeaturesTable,
    RunnerFeature,
    $$RunnerFeaturesTableFilterComposer,
    $$RunnerFeaturesTableOrderingComposer,
    $$RunnerFeaturesTableAnnotationComposer,
    $$RunnerFeaturesTableCreateCompanionBuilder,
    $$RunnerFeaturesTableUpdateCompanionBuilder,
    (
      RunnerFeature,
      BaseReferences<_$AppDatabase, $RunnerFeaturesTable, RunnerFeature>
    ),
    RunnerFeature,
    PrefetchHooks Function()> {
  $$RunnerFeaturesTableTableManager(
      _$AppDatabase db, $RunnerFeaturesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RunnerFeaturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RunnerFeaturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RunnerFeaturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> done = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RunnerFeaturesCompanion(
            id: id,
            title: title,
            description: description,
            icon: icon,
            color: color,
            status: status,
            done: done,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String description,
            required String icon,
            required String color,
            Value<String> status = const Value.absent(),
            Value<int> done = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RunnerFeaturesCompanion.insert(
            id: id,
            title: title,
            description: description,
            icon: icon,
            color: color,
            status: status,
            done: done,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RunnerFeaturesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RunnerFeaturesTable,
    RunnerFeature,
    $$RunnerFeaturesTableFilterComposer,
    $$RunnerFeaturesTableOrderingComposer,
    $$RunnerFeaturesTableAnnotationComposer,
    $$RunnerFeaturesTableCreateCompanionBuilder,
    $$RunnerFeaturesTableUpdateCompanionBuilder,
    (
      RunnerFeature,
      BaseReferences<_$AppDatabase, $RunnerFeaturesTable, RunnerFeature>
    ),
    RunnerFeature,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChecklistItemsTableTableManager get checklistItems =>
      $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
  $$MilestonesTableTableManager get milestones =>
      $$MilestonesTableTableManager(_db, _db.milestones);
  $$RequirementsTableTableManager get requirements =>
      $$RequirementsTableTableManager(_db, _db.requirements);
  $$RunnerFeaturesTableTableManager get runnerFeatures =>
      $$RunnerFeaturesTableTableManager(_db, _db.runnerFeatures);
}
