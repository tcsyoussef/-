import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';
import '../utilities/constants.dart';

class BackupService {
  BackupService(this.db);
  final AppDatabase db;

  Future<File> exportBackup() async {
    final data = await _collect();
    final dir = await getApplicationDocumentsDirectory();
    final backupDir = Directory(p.join(dir.path, 'backups'));
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    final stamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File(p.join(backupDir.path, 'level_up_backup_$stamp.json'));
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(data));
    await db.into(db.backupMetadata).insert(BackupMetadataCompanion.insert(
          version: LevelUpConstants.backupVersion,
          createdAt: DateTime.now(),
          path: Value(file.path),
          notes: const Value('Local JSON backup'),
        ));
    return file;
  }

  Future<void> importBackup(String jsonString) async {
    final decoded = jsonDecode(jsonString);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid backup format');
    }
    if (decoded['version'] == null) {
      throw const FormatException('Missing backup version');
    }

    await db.transaction(() async {
      for (final table in db.allTables) {
        await db.delete(table).go();
      }
    });

    // Re-import supported tables (best-effort structured restore).
    await _restoreTable(decoded['profiles'], (row) async {
      await db.into(db.profiles).insert(
            ProfilesCompanion.insert(
              wakeUp: Value(row['wakeUp'] as String? ?? '12:00'),
              sleepTime: Value(row['sleepTime'] as String? ?? '04:00'),
              dailyDevMinutes: Value(row['dailyDevMinutes'] as int? ?? 360),
              trainingLocation:
                  Value(row['trainingLocation'] as String? ?? 'Home'),
              englishLevel:
                  Value(row['englishLevel'] as String? ?? 'A2 / early B1'),
              englishTarget: Value(
                  row['englishTarget'] as String? ?? 'Strong B2 / late B2'),
              repairLevel: Value(row['repairLevel'] as String? ??
                  'Advanced motherboard diagnosis and repair'),
              equipmentNotes: Value(row['equipmentNotes'] as String? ?? ''),
              nutritionBudget:
                  Value(row['nutritionBudget'] as String? ?? 'Very low'),
              skincareStatus:
                  Value(row['skincareStatus'] as String? ?? 'None currently'),
              trainingStyle: Value(row['trainingStyle'] as String? ??
                  'Bodyweight + household backpack'),
              language: Value(row['language'] as String? ?? 'English'),
              currency: Value(row['currency'] as String? ?? 'MAD'),
              notes: Value(row['notes'] as String?),
            ),
          );
    });

    await _restoreTable(decoded['goals'], (row) async {
      await db.into(db.goals).insert(GoalsCompanion.insert(
            id: row['id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            sortOrder: row['sortOrder'] as int? ?? 0,
            progress: Value((row['progress'] as num?)?.toDouble() ?? 0),
          ));
    });

    await _restoreTable(decoded['tasks'], (row) async {
      await db.into(db.tasks).insert(TasksCompanion.insert(
            date: row['date'] as String,
            goalId: row['goalId'] as String,
            title: row['title'] as String,
            description: Value(row['description'] as String?),
            status: Value(row['status'] as String? ?? 'pending'),
            isDayOne: Value(row['isDayOne'] as bool? ?? false),
            sortOrder: Value(row['sortOrder'] as int? ?? 0),
          ));
    });

    await _restoreTable(decoded['scheduleBlocks'], (row) async {
      await db.into(db.scheduleBlocks).insert(ScheduleBlocksCompanion.insert(
            date: row['date'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            title: row['title'] as String,
            goalId: Value(row['goalId'] as String?),
            status: Value(row['status'] as String? ?? 'pending'),
            notes: Value(row['notes'] as String?),
            sortOrder: Value(row['sortOrder'] as int? ?? 0),
          ));
    });

    await _restoreTable(decoded['appSettings'], (row) async {
      await db.into(db.appSettings).insert(AppSettingsCompanion.insert(
            notificationsEnabled:
                Value(row['notificationsEnabled'] as bool? ?? true),
            notificationPermissionGranted:
                Value(row['notificationPermissionGranted'] as bool? ?? false),
            reminderWake: Value(row['reminderWake'] as String? ?? '12:00'),
            reminderFitness:
                Value(row['reminderFitness'] as String? ?? '12:30'),
            reminderEnglish1:
                Value(row['reminderEnglish1'] as String? ?? '14:30'),
            reminderRepairTheory:
                Value(row['reminderRepairTheory'] as String? ?? '15:45'),
            reminderEnglish2:
                Value(row['reminderEnglish2'] as String? ?? '18:15'),
            reminderRepairPractical:
                Value(row['reminderRepairPractical'] as String? ?? '19:30'),
            reminderAppearance:
                Value(row['reminderAppearance'] as String? ?? '20:30'),
            reminderSleep: Value(row['reminderSleep'] as String? ?? '03:30'),
          ));
    });

    await db.into(db.backupMetadata).insert(BackupMetadataCompanion.insert(
          version: LevelUpConstants.backupVersion,
          createdAt: DateTime.now(),
          notes: const Value('Restored from backup'),
        ));
  }

  Future<Map<String, dynamic>> _collect() async {
    Future<List<Map<String, dynamic>>> dump(TableInfo table) async {
      final rows = await db.select(table).get();
      return rows
          .map((r) => (r as DataClass).toJson(serializer: const _JsonSerializer()))
          .toList();
    }

    return {
      'version': LevelUpConstants.backupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'profiles': await dump(db.profiles),
      'appSettings': await dump(db.appSettings),
      'goals': await dump(db.goals),
      'roadmapMonths': await dump(db.roadmapMonths),
      'scheduleBlocks': await dump(db.scheduleBlocks),
      'tasks': await dump(db.tasks),
      'exercises': await dump(db.exercises),
      'workoutSessions': await dump(db.workoutSessions),
      'workoutSets': await dump(db.workoutSets),
      'measurements': await dump(db.measurements),
      'nutritionGuides': await dump(db.nutritionGuides),
      'englishLessons': await dump(db.englishLessons),
      'vocabEntries': await dump(db.vocabEntries),
      'englishSessions': await dump(db.englishSessions),
      'englishAssessments': await dump(db.englishAssessments),
      'repairLessons': await dump(db.repairLessons),
      'components': await dump(db.components),
      'equipmentItems': await dump(db.equipmentItems),
      'repairExercises': await dump(db.repairExercises),
      'measurementNotebook': await dump(db.measurementNotebook),
      'repairCases': await dump(db.repairCases),
      'appearanceRoutines': await dump(db.appearanceRoutines),
      'appearanceProducts': await dump(db.appearanceProducts),
      'groomingRecords': await dump(db.groomingRecords),
      'reviews': await dump(db.reviews),
      'achievements': await dump(db.achievements),
      'notificationPrefs': await dump(db.notificationPrefs),
    };
  }

  Future<void> _restoreTable(
    dynamic raw,
    Future<void> Function(Map<String, dynamic> row) insert,
  ) async {
    if (raw is! List) return;
    for (final item in raw) {
      if (item is Map<String, dynamic>) {
        await insert(item);
      } else if (item is Map) {
        await insert(Map<String, dynamic>.from(item));
      }
    }
  }
}

class _JsonSerializer extends ValueSerializer {
  const _JsonSerializer();

  @override
  T fromJson<T>(dynamic json) {
    if (json == null) return null as T;
    if (T == DateTime) return DateTime.parse(json as String) as T;
    if (T == double && json is int) return json.toDouble() as T;
    return json as T;
  }

  @override
  dynamic toJson<T>(T value) {
    if (value is DateTime) return value.toIso8601String();
    return value;
  }
}
