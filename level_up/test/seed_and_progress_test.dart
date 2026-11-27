import 'dart:ffi';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:level_up/database/app_database.dart';
import 'package:level_up/services/progress_service.dart';
import 'package:level_up/services/seed_service.dart';
import 'package:sqlite3/open.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    open.overrideFor(OperatingSystem.linux, () {
      return DynamicLibrary.open('libsqlite3.so.0');
    });
  });

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('seed creates profile, goals, day1 tasks, roadmap', () async {
    final seed = SeedService(db);
    await seed.ensureSeeded();

    final profiles = await db.select(db.profiles).get();
    expect(profiles, hasLength(1));
    expect(profiles.first.wakeUp, '12:00');

    final goals = await db.select(db.goals).get();
    expect(goals, hasLength(4));

    final months = await db.select(db.roadmapMonths).get();
    expect(months, hasLength(12));

    final day1Tasks = await (db.select(db.tasks)
          ..where((t) => t.isDayOne.equals(true)))
        .get();
    expect(day1Tasks.isNotEmpty, isTrue);

    final assessments = await db.select(db.englishAssessments).get();
    expect(assessments.length, greaterThanOrEqualTo(6));

    final blocks = await (db.select(db.scheduleBlocks)
          ..where((t) => t.date.equals('2026-11-27')))
        .get();
    expect(blocks.isNotEmpty, isTrue);
  });

  test('progress snapshot works on day 1', () async {
    await SeedService(db).ensureSeeded();
    final progress = await ProgressService(db).snapshot(DateTime(2026, 11, 27));
    expect(progress.dayNumber, 1);
    expect(progress.roadmapState, 'active');
    expect(progress.totalBlocksToday, greaterThan(0));
  });

  test('ensureSeeded is idempotent', () async {
    final seed = SeedService(db);
    await seed.ensureSeeded();
    await seed.ensureSeeded();
    final profiles = await db.select(db.profiles).get();
    expect(profiles, hasLength(1));
  });
}
