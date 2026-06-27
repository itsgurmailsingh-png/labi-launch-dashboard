import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class ChecklistItems extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()();
  TextColumn get title => text()();
  TextColumn get meta => text()();
  TextColumn get tag => text().withDefault(const Constant(''))();
  IntColumn get done => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Milestones extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get date => text()();
  TextColumn get status => text()();
  TextColumn get linkedIds => text().withDefault(const Constant(''))();
  IntColumn get done => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Requirements extends Table {
  TextColumn get id => text()();
  TextColumn get groupName => text()();
  TextColumn get name => text()();
  TextColumn get note => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('todo'))();

  @override
  Set<Column> get primaryKey => {id};
}

class RunnerFeatures extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  TextColumn get status => text().withDefault(const Constant('todo'))();
  IntColumn get done => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [ChecklistItems, Milestones, Requirements, RunnerFeatures])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Checklist queries
  Stream<List<ChecklistItem>> watchByCategory(String category) =>
      (select(checklistItems)..where((t) => t.category.equals(category))).watch();

  Stream<List<ChecklistItem>> watchAllChecklist() => select(checklistItems).watch();

  Future<void> toggleChecklistItem(String id) async {
    await customUpdate(
      'UPDATE checklist_items SET done = 1 - done WHERE id = ?',
      variables: [Variable.withString(id)],
      updates: {checklistItems},
    );
  }

  Future<void> setChecklistDone(String id, bool done) async {
    await (update(checklistItems)..where((t) => t.id.equals(id)))
        .write(ChecklistItemsCompanion(done: Value(done ? 1 : 0)));
  }

  // Milestone queries
  Stream<List<Milestone>> watchAllMilestones() => select(milestones).watch();

  Future<void> toggleMilestone(String id) async {
    await customUpdate(
      'UPDATE milestones SET done = 1 - done WHERE id = ?',
      variables: [Variable.withString(id)],
      updates: {milestones},
    );
  }

  // Requirement queries
  Stream<List<Requirement>> watchAllRequirements() => select(requirements).watch();

  Future<void> cycleRequirementStatus(String id, String currentStatus) async {
    final next = currentStatus == 'todo'
        ? 'wip'
        : currentStatus == 'wip'
            ? 'done'
            : 'todo';
    await (update(requirements)..where((t) => t.id.equals(id)))
        .write(RequirementsCompanion(status: Value(next)));
  }

  // Runner feature queries
  Stream<List<RunnerFeature>> watchAllRunnerFeatures() => select(runnerFeatures).watch();

  Future<void> cycleRunnerStatus(String id, String currentStatus) async {
    final next = currentStatus == 'todo'
        ? 'wip'
        : currentStatus == 'wip'
            ? 'done'
            : 'todo';
    await (update(runnerFeatures)..where((t) => t.id.equals(id)))
        .write(RunnerFeaturesCompanion(status: Value(next)));
  }

  // Stats
  Future<Map<String, int>> getChecklistStats(String category) async {
    final all = await (select(checklistItems)..where((t) => t.category.equals(category))).get();
    final done = all.where((i) => i.done == 1).length;
    return {'total': all.length, 'done': done};
  }

  Future<Map<String, int>> getMilestoneStats() async {
    final all = await select(milestones).get();
    final done = all.where((m) => m.done == 1).length;
    return {'total': all.length, 'done': done};
  }

  Future<List<ChecklistItem>> getCriticalBlockers() async {
    return (select(checklistItems)
          ..where((t) => t.tag.equals('crit') & t.done.equals(0))
          ..orderBy([(t) => OrderingTerm.asc(t.category)]))
        .get();
  }

  Future<ChecklistItem?> getNextAction() async {
    final critItems = await (select(checklistItems)
          ..where((t) => t.tag.equals('crit') & t.done.equals(0))
          ..orderBy([(t) => OrderingTerm.asc(t.category)])
          ..limit(1))
        .get();
    if (critItems.isNotEmpty) return critItems.first;

    final coreItems = await (select(checklistItems)
          ..where((t) => t.tag.equals('core') & t.done.equals(0))
          ..orderBy([(t) => OrderingTerm.asc(t.category)])
          ..limit(1))
        .get();
    return coreItems.isNotEmpty ? coreItems.first : null;
  }

  Future<bool> isEmpty() async {
    final count = await (select(checklistItems)..limit(1)).get();
    return count.isEmpty;
  }

  Future<void> insertChecklistItem(ChecklistItemsCompanion item) =>
      into(checklistItems).insert(item);

  Future<void> insertMilestone(MilestonesCompanion item) =>
      into(milestones).insert(item);

  Future<void> insertRequirement(RequirementsCompanion item) =>
      into(requirements).insert(item);

  Future<void> insertRunnerFeature(RunnerFeaturesCompanion item) =>
      into(runnerFeatures).insert(item);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'labi_launch.db'));
    return NativeDatabase.createInBackground(file);
  });
}
