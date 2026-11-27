import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../services/backup_service.dart';
import '../services/notification_service.dart';
import '../services/progress_service.dart';
import '../services/seed_service.dart';
import '../utilities/date_utils.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final seedServiceProvider = Provider<SeedService>((ref) {
  return SeedService(ref.watch(databaseProvider));
});

final progressServiceProvider = Provider<ProgressService>((ref) {
  return ProgressService(ref.watch(databaseProvider));
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(databaseProvider));
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.watch(databaseProvider));
});

final bootstrapProvider = FutureProvider<void>((ref) async {
  final seed = ref.watch(seedServiceProvider);
  await seed.ensureSeeded();
  final today = DateTime.now();
  await seed.ensureScheduleForDate(today);
  await seed.ensureScheduleForDate(LevelUpDateUtils.parseDate('2026-11-27'));
  try {
    final notifications = ref.watch(notificationServiceProvider);
    await notifications.init();
    await notifications.syncFromPrefs();
  } catch (_) {
    // Notifications may fail on unsupported platforms; app must still run.
  }
});

final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final profileProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db
      .select(db.profiles)
      .watch()
      .map((rows) => rows.isEmpty ? null : rows.first);
});

final settingsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db
      .select(db.appSettings)
      .watch()
      .map((rows) => rows.isEmpty ? null : rows.first);
});

final goalsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.goals)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
      .watch();
});

final roadmapProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.roadmapMonths)
        ..orderBy([(t) => OrderingTerm.asc(t.monthIndex)]))
      .watch();
});

final progressProvider = FutureProvider.autoDispose((ref) async {
  final date = ref.watch(selectedDateProvider);
  return ref.watch(progressServiceProvider).snapshot(date);
});

final scheduleProvider = StreamProvider.autoDispose((ref) {
  final db = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider);
  final key = LevelUpDateUtils.formatDate(date);
  return (db.select(db.scheduleBlocks)
        ..where((t) => t.date.equals(key))
        ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
      .watch();
});

final tasksForSelectedDateProvider = StreamProvider.autoDispose((ref) {
  final db = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider);
  final key = LevelUpDateUtils.formatDate(date);
  return (db.select(db.tasks)
        ..where((t) => t.date.equals(key))
        ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
      .watch();
});

final dayOneTasksProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.tasks)
        ..where((t) => t.isDayOne.equals(true))
        ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
      .watch();
});

final workoutSessionsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.workoutSessions)
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final exercisesProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.exercises).watch();
});

final measurementsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.measurements)..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final nutritionProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.nutritionGuides).watch();
});

final englishLessonsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.englishLessons)
        ..orderBy([
          (t) => OrderingTerm.asc(t.monthIndex),
          (t) => OrderingTerm.asc(t.weekIndex),
        ]))
      .watch();
});

final vocabProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.vocabEntries)..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final englishAssessmentsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.englishAssessments)
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final englishSessionsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.englishSessions)
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final repairLessonsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.repairLessons).watch();
});

final equipmentProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.equipmentItems).watch();
});

final componentsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.components).watch();
});

final repairExercisesProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.repairExercises).watch();
});

final repairCasesProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.repairCases)..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final measurementNotebookProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.measurementNotebook)
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final appearanceRoutinesProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.appearanceRoutines)
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final appearanceProductsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.appearanceProducts).watch();
});

final groomingProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.groomingRecords)
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final reviewsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.reviews)..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();
});

final achievementsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.achievements).watch();
});

final notificationPrefsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.notificationPrefs).watch();
});
