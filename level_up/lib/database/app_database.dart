import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wakeUp => text().withDefault(const Constant('12:00'))();
  TextColumn get sleepTime => text().withDefault(const Constant('04:00'))();
  IntColumn get dailyDevMinutes => integer().withDefault(const Constant(360))();
  TextColumn get trainingLocation =>
      text().withDefault(const Constant('Home'))();
  TextColumn get englishLevel =>
      text().withDefault(const Constant('A2 / early B1'))();
  TextColumn get englishTarget =>
      text().withDefault(const Constant('Strong B2 / late B2'))();
  TextColumn get repairLevel => text()
      .withDefault(const Constant('Advanced motherboard diagnosis and repair'))();
  TextColumn get equipmentNotes => text().withDefault(const Constant(
      'Basic digital multimeter; one faulty laptop motherboard'))();
  TextColumn get nutritionBudget =>
      text().withDefault(const Constant('Very low'))();
  TextColumn get skincareStatus =>
      text().withDefault(const Constant('None currently'))();
  TextColumn get trainingStyle =>
      text().withDefault(const Constant('Bodyweight + household backpack'))();
  TextColumn get language => text().withDefault(const Constant('English'))();
  TextColumn get currency => text().withDefault(const Constant('MAD'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notificationPermissionGranted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get reminderWake =>
      text().withDefault(const Constant('12:00'))();
  TextColumn get reminderFitness =>
      text().withDefault(const Constant('12:30'))();
  TextColumn get reminderEnglish1 =>
      text().withDefault(const Constant('14:30'))();
  TextColumn get reminderRepairTheory =>
      text().withDefault(const Constant('15:45'))();
  TextColumn get reminderEnglish2 =>
      text().withDefault(const Constant('18:15'))();
  TextColumn get reminderRepairPractical =>
      text().withDefault(const Constant('19:30'))();
  TextColumn get reminderAppearance =>
      text().withDefault(const Constant('20:30'))();
  TextColumn get reminderSleep =>
      text().withDefault(const Constant('03:30'))();
  TextColumn get themeMode => text().withDefault(const Constant('dark'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get sortOrder => integer()();
  RealColumn get progress => real().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class RoadmapMonths extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monthIndex => integer()();
  IntColumn get quarter => integer()();
  TextColumn get title => text()();
  TextColumn get focus => text()();
  TextColumn get objectives => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
}

class ScheduleBlocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  TextColumn get title => text()();
  TextColumn get goalId => text().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('pending'))(); // pending/in_progress/completed/skipped/postponed
  TextColumn get notes => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class ScheduleHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get blockId => integer()();
  TextColumn get previousStatus => text()();
  TextColumn get newStatus => text()();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get changedAt => dateTime().withDefault(currentDateAndTime)();
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get goalId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  BoolColumn get isDayOne => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()(); // upper_a, lower_a, etc.
  TextColumn get instructions => text()();
  IntColumn get defaultSets => integer().withDefault(const Constant(3))();
  TextColumn get defaultReps => text().withDefault(const Constant('10'))();
  IntColumn get restSeconds => integer().withDefault(const Constant(60))();
  BoolColumn get beginnerSafe => boolean().withDefault(const Constant(true))();
}

class WorkoutSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get planName => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class WorkoutSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer()();
  IntColumn get exerciseId => integer()();
  IntColumn get setNumber => integer()();
  TextColumn get targetReps => text()();
  TextColumn get actualReps => text().nullable()();
  RealColumn get weightKg => real().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  BoolColumn get isPr => boolean().withDefault(const Constant(false))();
}

class Measurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  RealColumn get weightKg => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  IntColumn get pushUps => integer().nullable()();
  IntColumn get squats => integer().nullable()();
  IntColumn get plankSeconds => integer().nullable()();
  TextColumn get resistanceNotes => text().nullable()();
  RealColumn get consistencyScore => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class NutritionGuides extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get category => text()();
}

class EnglishLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monthIndex => integer()();
  IntColumn get weekIndex => integer()();
  TextColumn get theme => text()();
  TextColumn get grammarFocus => text()();
  TextColumn get vocabFocus => text()();
  TextColumn get content => text()();
}

class VocabEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text()();
  TextColumn get meaning => text()();
  TextColumn get example => text().nullable()();
  TextColumn get date => text()();
  IntColumn get revisionCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastReviewed => dateTime().nullable()();
}

class EnglishSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  IntColumn get sessionNumber => integer()(); // 1 or 2
  IntColumn get grammarMinutes => integer().withDefault(const Constant(0))();
  IntColumn get vocabMinutes => integer().withDefault(const Constant(0))();
  IntColumn get listeningMinutes => integer().withDefault(const Constant(0))();
  IntColumn get readingMinutes => integer().withDefault(const Constant(0))();
  IntColumn get speakingMinutes => integer().withDefault(const Constant(0))();
  IntColumn get writingMinutes => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
}

class EnglishAssessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get type => text()(); // grammar/vocab/listening/reading/speaking/writing/weekly/monthly
  IntColumn get score => integer()();
  IntColumn get maxScore => integer().withDefault(const Constant(20))();
  TextColumn get notes => text().nullable()();
  TextColumn get writingSample => text().nullable()();
  TextColumn get recordingPath => text().nullable()();
}

class RepairLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monthIndex => integer()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get lessonType => text()(); // theory/practical
  BoolColumn get requiresEquipment =>
      boolean().withDefault(const Constant(false))();
  TextColumn get requiredEquipment => text().nullable()();
  BoolColumn get safetyCritical =>
      boolean().withDefault(const Constant(false))();
}

class Components extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get typicalValues => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class EquipmentItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get owned => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get acquiredAt => dateTime().nullable()();
}

class RepairExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get instructions => text()();
  BoolColumn get locked => boolean().withDefault(const Constant(false))();
  TextColumn get requiredEquipment => text().nullable()();
  TextColumn get safetyNotes => text().nullable()();
}

class MeasurementNotebook extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get point => text()();
  TextColumn get value => text()();
  TextColumn get unit => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get unpoweredOnly =>
      boolean().withDefault(const Constant(true))();
}

class RepairCases extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get model => text()();
  TextColumn get symptoms => text()();
  TextColumn get diagnosis => text().nullable()();
  TextColumn get workflow => text().nullable()();
  TextColumn get parts => text().nullable()();
  TextColumn get outcome => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class AppearanceRoutines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get routineType => text()(); // morning/evening/weekly
  TextColumn get checklistJson => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class AppearanceProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()(); // cleanser/moisturizer/spf/etc
  TextColumn get brand => text().nullable()();
  RealColumn get priceMad => real().nullable()();
  BoolColumn get owned => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
}

class AppearancePhotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get angle => text()(); // front/side
  TextColumn get filePath => text()();
  TextColumn get notes => text().nullable()();
}

class GroomingRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get type => text()(); // haircut/beard/dental
  TextColumn get details => text()();
  TextColumn get condition => text().nullable()();
}

class Reviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get type => text()(); // weekly/monthly
  TextColumn get content => text()();
  RealColumn get consistencyScore => real().nullable()();
  RealColumn get achievementScore => real().nullable()();
}

class Achievements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
  BoolColumn get unlocked => boolean().withDefault(const Constant(false))();
}

class NotificationPrefs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get timeHhMm => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
}

class BackupMetadata extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get version => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get path => text().nullable()();
  TextColumn get notes => text().nullable()();
}

@DriftDatabase(tables: [
  Profiles,
  AppSettings,
  Goals,
  RoadmapMonths,
  ScheduleBlocks,
  ScheduleHistory,
  Tasks,
  Exercises,
  WorkoutSessions,
  WorkoutSets,
  Measurements,
  NutritionGuides,
  EnglishLessons,
  VocabEntries,
  EnglishSessions,
  EnglishAssessments,
  RepairLessons,
  Components,
  EquipmentItems,
  RepairExercises,
  MeasurementNotebook,
  RepairCases,
  AppearanceRoutines,
  AppearanceProducts,
  AppearancePhotos,
  GroomingRecords,
  Reviews,
  Achievements,
  NotificationPrefs,
  BackupMetadata,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'level_up.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
