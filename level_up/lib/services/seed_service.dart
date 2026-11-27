import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../utilities/constants.dart';
import '../utilities/date_utils.dart';

class SeedService {
  SeedService(this.db);
  final AppDatabase db;

  Future<void> ensureSeeded() async {
    final existing = await db.select(db.profiles).get();
    if (existing.isNotEmpty) return;
    await _seedAll();
  }

  Future<void> resetAndReseed() async {
    await db.transaction(() async {
      for (final table in db.allTables) {
        await db.delete(table).go();
      }
    });
    await _seedAll();
  }

  Future<void> _seedAll() async {
    await _seedProfile();
    await _seedSettings();
    await _seedGoals();
    await _seedRoadmap();
    await _seedExercises();
    await _seedNutrition();
    await _seedEnglishCurriculum();
    await _seedRepair();
    await _seedAppearanceProducts();
    await _seedNotifications();
    await _seedAchievements();
    await _seedDayOne();
    await _seedDefaultScheduleTemplate();
  }

  Future<void> _seedProfile() async {
    await db.into(db.profiles).insert(ProfilesCompanion.insert(
          wakeUp: const Value(LevelUpConstants.wakeUpDefault),
          sleepTime: const Value(LevelUpConstants.sleepDefault),
          dailyDevMinutes: const Value(LevelUpConstants.dailyDevMinutes),
          trainingLocation: const Value(LevelUpConstants.trainingLocation),
          englishLevel: const Value('A2 / early B1'),
          englishTarget: const Value('Strong B2 / late B2'),
          repairLevel:
              const Value('Advanced motherboard diagnosis and repair'),
          equipmentNotes: const Value(
              'Basic digital multimeter; one faulty laptop motherboard'),
          nutritionBudget: const Value('Very low'),
          skincareStatus: const Value('None currently'),
          trainingStyle: const Value('Bodyweight + household backpack'),
          language: const Value(LevelUpConstants.language),
          currency: const Value(LevelUpConstants.currency),
          notes: const Value(
              'Private 365-day transformation. Offline-first. No accounts.'),
        ));
  }

  Future<void> _seedSettings() async {
    await db.into(db.appSettings).insert(AppSettingsCompanion.insert());
  }

  Future<void> _seedGoals() async {
    final goals = [
      GoalsCompanion.insert(
        id: 'fitness',
        title: 'Fitness',
        description:
            'Athletic physique at home with bodyweight + backpack. Beginner-safe progression.',
        sortOrder: 0,
      ),
      GoalsCompanion.insert(
        id: 'english',
        title: 'English',
        description:
            'A2 → Strong B2. 2h/day Mon–Sat: grammar, vocab, listen, read, speak, write.',
        sortOrder: 1,
      ),
      GoalsCompanion.insert(
        id: 'repair',
        title: 'Repair Academy',
        description:
            'Laptop motherboard diagnosis & repair. Multimeter + practice board first.',
        sortOrder: 2,
      ),
      GoalsCompanion.insert(
        id: 'appearance',
        title: 'Appearance',
        description:
            'Affordable grooming, skincare, haircut/beard/dental habits. Private photos.',
        sortOrder: 3,
      ),
    ];
    await db.batch((b) => b.insertAll(db.goals, goals));
  }

  Future<void> _seedRoadmap() async {
    final start = LevelUpConstants.roadmapStart;
    final focuses = [
      // Q1
      ('Foundation & Assessment', 'Baseline fitness, English diagnostics, safe electrical basics, appearance kickoff.'),
      ('Habit Lock-In', 'Consistent schedule, upper/lower splits, present simple mastery, continuity testing.'),
      ('Volume Build', 'Add sets carefully, past tenses, MOSFET basics, morning/evening routines.'),
      ('Q1 Review', 'Monthly assessments, form checks, vocab revision, board photo portfolio.'),
      // Q2
      ('Strength Base', 'Progressive overload with backpack, listening stamina, power rails theory.'),
      ('Skill Depth', 'Mobility quality, writing fluency, short/open circuits practice.'),
      ('Consistency Sprint', 'PR tracking, weekly English tests, equipment checklist growth.'),
      ('Mid-Year Checkpoint', 'Q2 reviews, B1 evidence, unpowered diagnosis workflow.'),
      // Q3
      ('Athletic Push', 'Harder bodyweight progressions, B1→B2 grammar, practical repair cases.'),
      ('Expression', 'Speaking recordings, reading volume, schematic note-taking.'),
      ('Technician Habits', 'Case templates, measurement notebook rigor, appearance monthly photos.'),
      // Q4
      ('Peak & Polish', 'Late B2 targets, advanced diagnosis notes, physique consistency, final review.'),
    ];

    final titles = [
      'Month 1 — Nov/Dec 2026',
      'Month 2 — Dec 2026/Jan 2027',
      'Month 3 — Jan/Feb 2027',
      'Month 4 — Feb/Mar 2027',
      'Month 5 — Mar/Apr 2027',
      'Month 6 — Apr/May 2027',
      'Month 7 — May/Jun 2027',
      'Month 8 — Jun/Jul 2027',
      'Month 9 — Jul/Aug 2027',
      'Month 10 — Aug/Sep 2027',
      'Month 11 — Sep/Oct 2027',
      'Month 12 — Oct/Nov 2027',
    ];

    for (var i = 0; i < 12; i++) {
      final mStart = DateTime(start.year, start.month + i, start.day);
      final mEnd = DateTime(start.year, start.month + i + 1, start.day)
          .subtract(const Duration(days: 1));
      final clampedEnd = mEnd.isAfter(LevelUpConstants.roadmapEnd)
          ? LevelUpConstants.roadmapEnd
          : mEnd;
      await db.into(db.roadmapMonths).insert(RoadmapMonthsCompanion.insert(
            monthIndex: i,
            quarter: (i ~/ 3) + 1,
            title: titles[i],
            focus: focuses[i].$1,
            objectives: focuses[i].$2,
            startDate: mStart,
            endDate: clampedEnd,
          ));
    }
  }

  Future<void> _seedExercises() async {
    final list = <ExercisesCompanion>[
      // Upper A
      _ex('Incline push-ups', 'upper_a',
          'Hands elevated on a stable surface. Keep body straight. No sharp pain.', 3, '8-12'),
      _ex('Backpack rows', 'upper_a',
          'Hinge at hips, pull backpack to torso, squeeze shoulder blades.', 3, '10-12'),
      _ex('Pike push-up progression', 'upper_a',
          'Hips high, lower head toward floor gently. Stop before sharp pain.', 3, '6-10'),
      _ex('Dead bugs', 'abs',
          'Opposite arm/leg extend while keeping low back pressed down.', 3, '8/side'),
      _ex('Plank', 'abs', 'Forearms down, body straight. Breathe steadily.', 3, '20-40s'),
      // Lower A
      _ex('Bodyweight squats', 'lower_a',
          'Feet shoulder-width, sit back, knees track toes. Controlled tempo.', 3, '10-15'),
      _ex('Glute bridges', 'lower_a',
          'Lie on back, drive through heels, squeeze glutes at top.', 3, '12-15'),
      _ex('Reverse lunges', 'lower_a',
          'Step back, front knee soft, torso upright. Alternate sides.', 3, '8/side'),
      _ex('Wall angels / posture', 'posture',
          'Back against wall, slide arms up/down maintaining contact.', 2, '10'),
      // Upper B
      _ex('Knee push-ups', 'upper_b',
          'Modified push-up. Full range without shoulder pain.', 3, '8-12'),
      _ex('Backpack curls', 'upper_b',
          'Stand tall, curl backpack handles. No swinging.', 3, '10-12'),
      _ex('Superman holds', 'upper_b',
          'Lie prone, lift chest and legs gently. Hold briefly.', 3, '8-10'),
      // Lower B
      _ex('Split squats', 'lower_b',
          'Rear foot elevated if available; otherwise static split stance.', 3, '8/side'),
      _ex('Calf raises', 'lower_b', 'Rise onto toes, pause, lower slowly.', 3, '12-15'),
      _ex('Side-lying hip raises', 'lower_b',
          'Lie on side, lift top leg with control.', 3, '10/side'),
      // Mobility / walk days
      _ex('Brisk walk', 'mobility', '30–45 min easy-to-moderate pace outdoors or indoors.', 1, '30-45m'),
      _ex('Hip openers', 'mobility', 'Gentle 90/90 or figure-four stretches. No forcing.', 2, '60s/side'),
      _ex('Thoracic rotations', 'mobility', 'On all fours, reach under then open to ceiling.', 2, '8/side'),
      _ex('Cat-cow', 'mobility', 'Slow spinal flexion/extension synchronized with breath.', 2, '10'),
      _ex('Core hollow holds', 'core', 'Press low back down, hold gentle tension.', 3, '15-25s'),
    ];
    await db.batch((b) => b.insertAll(db.exercises, list));
  }

  ExercisesCompanion _ex(
    String name,
    String category,
    String instructions,
    int sets,
    String reps,
  ) {
    return ExercisesCompanion.insert(
      name: name,
      category: category,
      instructions: instructions,
      defaultSets: Value(sets),
      defaultReps: Value(reps),
      restSeconds: const Value(60),
      beginnerSafe: const Value(true),
    );
  }

  Future<void> _seedNutrition() async {
    final guides = [
      NutritionGuidesCompanion.insert(
        title: 'Affordable Moroccan staples',
        category: 'staples',
        content:
            'Eggs, lentils, beans, sardines, chicken when affordable, milk/yogurt, seasonal vegetables, rice, potatoes, oats. Prioritize protein + carbs around training. No expensive supplements required.',
      ),
      NutritionGuidesCompanion.insert(
        title: 'Sample day (very low budget)',
        category: 'meals',
        content:
            'Breakfast: oats + milk + banana if available.\nLunch: lentils/beans + rice + salad.\nSnack: yogurt or eggs.\nDinner: potatoes + eggs/sardines + vegetables.\nWater: aim 2.5–3.5L depending on climate/training.',
      ),
      NutritionGuidesCompanion.insert(
        title: 'Weekly planning tips',
        category: 'planning',
        content:
            'Buy staples in bulk when possible. Batch-cook lentils/rice. Keep eggs and canned sardines as protein backups. Track water with habit checkmarks. No extreme restriction.',
      ),
    ];
    await db.batch((b) => b.insertAll(db.nutritionGuides, guides));
  }

  Future<void> _seedEnglishCurriculum() async {
    final themes = [
      (0, 1, 'Self & routines', 'Present simple / to be', 'Daily verbs, time words'),
      (0, 2, 'Home & habits', 'Present continuous', 'Home vocabulary'),
      (0, 3, 'Food & health', 'Countable/uncountable', 'Food & body'),
      (0, 4, 'Past stories', 'Past simple', 'Irregular verbs set 1'),
      (1, 1, 'Plans', 'Going to / will', 'Future time markers'),
      (1, 2, 'Comparisons', 'Comparatives', 'Adjectives of appearance'),
      (1, 3, 'Experience', 'Present perfect intro', 'Life experience verbs'),
      (1, 4, 'Opinions', 'Because / although', 'Opinion phrases'),
      (2, 1, 'Work & skills', 'Modals can/must', 'Workplace verbs'),
      (2, 2, 'Tech basics', 'Passives intro', 'Hardware nouns'),
      (2, 3, 'Problem solving', 'Conditionals 0/1', 'Logic connectors'),
      (2, 4, 'Review month', 'Mixed tenses', 'Revision pack A'),
    ];

    for (final t in themes) {
      await db.into(db.englishLessons).insert(EnglishLessonsCompanion.insert(
            monthIndex: t.$1,
            weekIndex: t.$2,
            theme: t.$3,
            grammarFocus: t.$4,
            vocabFocus: t.$5,
            content:
                'Session 1 (60m): Grammar 25 / Vocab 20 / Listening 15.\n'
                'Session 2 (60m): Reading 20 / Speaking 20 / Writing 20.\n'
                'Theme: ${t.$3}. Focus grammar on ${t.$4}. Build a vocab notebook for ${t.$5}.',
          ));
    }

    // Extend months 4–12 with progressive titles
    for (var m = 3; m < 12; m++) {
      await db.into(db.englishLessons).insert(EnglishLessonsCompanion.insert(
            monthIndex: m,
            weekIndex: 1,
            theme: 'Month ${m + 1} curriculum',
            grammarFocus: m < 6
                ? 'Narrative tenses & connectors'
                : (m < 9 ? 'Conditionals & reported speech' : 'Advanced cohesion / nuance'),
            vocabFocus: m < 6
                ? 'Academic & daily expansion'
                : (m < 9 ? 'Technical + debate vocabulary' : 'Idioms & precise collocations'),
            content:
                'Progress toward Strong B2. Keep dual 60-minute sessions Mon–Sat. '
                'Weekly test + monthly assessment. Manual scoring only — no fake speech AI.',
          ));
    }
  }

  Future<void> _seedRepair() async {
    final lessons = [
      RepairLessonsCompanion.insert(
        monthIndex: 0,
        title: 'Electrical fundamentals',
        lessonType: 'theory',
        content:
            'Voltage, current, resistance, continuity, open vs short. Ohm\'s law. Safety first: never inject voltage into unknown circuits.',
        safetyCritical: const Value(true),
      ),
      RepairLessonsCompanion.insert(
        monthIndex: 0,
        title: 'Board familiarization (unpowered)',
        lessonType: 'practical',
        content:
            'Photograph board, mark model, inspect damage, identify DC-in, MOSFETs, coils, capacitors. Multimeter continuity/resistance only while unpowered.',
        requiresEquipment: const Value(true),
        requiredEquipment: const Value('multimeter,practice_board'),
        safetyCritical: const Value(true),
      ),
      RepairLessonsCompanion.insert(
        monthIndex: 1,
        title: 'Power rails overview',
        lessonType: 'theory',
        content:
            'Identify common laptop rails conceptually. Document expected vs measured only when safe and trained. Prefer unpowered checks first.',
        safetyCritical: const Value(true),
      ),
      RepairLessonsCompanion.insert(
        monthIndex: 2,
        title: 'MOSFET identification',
        lessonType: 'theory',
        content:
            'Locate high-side/low-side candidates visually. Note package markings. Build component library entries.',
      ),
    ];
    await db.batch((b) => b.insertAll(db.repairLessons, lessons));

    final equipment = [
      ('Practice board / faulty motherboard', true),
      ('Digital multimeter', true),
      ('Soldering station', false),
      ('Soldering accessories', false),
      ('Bench PSU', false),
      ('Microscope', false),
      ('Hot-air station', false),
      ('BIOS programmer', false),
    ];
    for (final e in equipment) {
      await db.into(db.equipmentItems).insert(EquipmentItemsCompanion.insert(
            name: e.$1,
            owned: Value(e.$2),
          ));
    }

    final components = [
      ('MOSFET', 'Switching transistor used on power rails', 'Check for shorts drain-source unpowered'),
      ('Inductor / coil', 'Energy storage in buck converters', 'Look for burnt enamel / open windings'),
      ('Electrolytic / MLCC capacitor', 'Filtering and decoupling', 'Bulging, missing, cracked caps'),
      ('DC jack / DC-in path', 'Input power entry', 'Mechanical damage, open fuse'),
    ];
    for (final c in components) {
      await db.into(db.components).insert(ComponentsCompanion.insert(
            name: c.$1,
            description: c.$2,
            notes: Value(c.$3),
          ));
    }

    await db.into(db.repairExercises).insert(RepairExercisesCompanion.insert(
          title: 'Unpowered continuity map',
          instructions:
              'With board unpowered, map continuity from DC-in to first filter/fuse area. Record ohms. Stop if unsure.',
          locked: const Value(false),
          requiredEquipment: const Value('multimeter,practice_board'),
          safetyNotes: const Value(
              'No voltage injection into unknown circuits. Unpowered only.'),
        ));
    await db.into(db.repairExercises).insert(RepairExercisesCompanion.insert(
          title: 'Hot-air rework practice (locked)',
          instructions: 'Requires hot-air station. Locked until equipment owned.',
          locked: const Value(true),
          requiredEquipment: const Value('hot_air'),
          safetyNotes: const Value('Do not attempt without proper tools and ESD setup.'),
        ));
  }

  Future<void> _seedAppearanceProducts() async {
    final products = [
      ('Gentle cleanser', 'cleanser', 25.0),
      ('Basic moisturizer', 'moisturizer', 30.0),
      ('SPF 30+', 'spf', 40.0),
      ('Toothbrush + toothpaste', 'dental', 15.0),
      ('Floss', 'dental', 10.0),
    ];
    for (final p in products) {
      await db.into(db.appearanceProducts).insert(
            AppearanceProductsCompanion.insert(
              name: p.$1,
              category: p.$2,
              priceMad: Value(p.$3),
              owned: const Value(false),
              notes: const Value('Affordable target — buy when budget allows.'),
            ),
          );
    }
  }

  Future<void> _seedNotifications() async {
    final items = [
      ('wake', 'Wake & hygiene', 'Start Day with hygiene block', '12:00'),
      ('fitness', 'Fitness block', 'Training starts — Upper/Lower/Mobility', '12:30'),
      ('english1', 'English Session 1', 'Grammar / vocab / listening', '14:30'),
      ('repair_theory', 'Repair theory', 'Motherboard theory block', '15:45'),
      ('english2', 'English Session 2', 'Reading / speaking / writing', '18:15'),
      ('repair_practical', 'Repair practical', 'Practical / unpowered work', '19:30'),
      ('appearance', 'Appearance routine', 'Evening appearance checklist', '20:30'),
      ('sleep', 'Sleep prep', 'Wind down for 04:00 sleep', '03:30'),
    ];
    for (final n in items) {
      await db.into(db.notificationPrefs).insert(
            NotificationPrefsCompanion.insert(
              key: n.$1,
              title: n.$2,
              body: n.$3,
              timeHhMm: n.$4,
            ),
          );
    }
  }

  Future<void> _seedAchievements() async {
    final list = [
      ('day1_complete', 'Day 1 Locked In', 'Complete all Day 1 missions'),
      ('week1_consistency', 'Week 1 Consistency', 'Complete 5+ scheduled blocks in week 1'),
      ('first_pr', 'First PR', 'Log a personal record set'),
      ('vocab_50', 'Vocab Builder', 'Add 50 vocabulary entries'),
      ('repair_case_1', 'First Case', 'Document first repair case'),
      ('appearance_7', 'Grooming Streak', '7 appearance routines completed'),
    ];
    for (final a in list) {
      await db.into(db.achievements).insert(AchievementsCompanion.insert(
            code: a.$1,
            title: a.$2,
            description: a.$3,
          ));
    }
  }

  Future<void> _seedDayOne() async {
    const day1 = '2026-11-27';

    // Fitness Day 1 workout
    final sessionId = await db.into(db.workoutSessions).insert(
          WorkoutSessionsCompanion.insert(
            date: day1,
            planName: 'Day 1 — Full-body intro',
            status: const Value('pending'),
            notes: const Value(
                'Warm-up 5m + cooldown stretch. Beginner volume. No sharp pain.'),
          ),
        );

    final day1Moves = [
      ('Bodyweight squats', '2', '10'),
      ('Incline push-ups', '2', '8'),
      ('Glute bridges', '2', '12'),
      ('Backpack rows', '2', '10'),
      ('Dead bugs', '2', '8/side'),
      ('Plank', '2', '15-20s'),
    ];
    for (final m in day1Moves) {
      final ex = await (db.select(db.exercises)
            ..where((t) => t.name.equals(m.$1)))
          .getSingleOrNull();
      if (ex == null) continue;
      final sets = int.parse(m.$2);
      for (var s = 1; s <= sets; s++) {
        await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
              sessionId: sessionId,
              exerciseId: ex.id,
              setNumber: s,
              targetReps: m.$3,
            ));
      }
    }

    await db.into(db.measurements).insert(MeasurementsCompanion.insert(
          date: day1,
          notes: const Value(
              'Initial Day 1 measurements — fill weight, waist, push-up, squat, plank.'),
        ));

    // English Day 1 assessments
    final assessmentTypes = [
      'grammar',
      'vocab',
      'listening',
      'reading',
      'speaking',
      'writing',
    ];
    for (final t in assessmentTypes) {
      await db.into(db.englishAssessments).insert(
            EnglishAssessmentsCompanion.insert(
              date: day1,
              type: t,
              score: 0,
              maxScore: const Value(20),
              notes: Value(
                  'Day 1 baseline $t assessment (manual). Writing: 150-word intro when ready.'),
              writingSample: t == 'writing'
                  ? const Value('Write a 150-word self-introduction here.')
                  : const Value.absent(),
            ),
          );
    }

    await db.into(db.englishSessions).insert(EnglishSessionsCompanion.insert(
          date: day1,
          sessionNumber: 1,
          status: const Value('pending'),
          notes: const Value('Baseline assessments + light Session 1 structure.'),
        ));
    await db.into(db.englishSessions).insert(EnglishSessionsCompanion.insert(
          date: day1,
          sessionNumber: 2,
          status: const Value('pending'),
          notes: const Value('Reading/speaking/writing baselines.'),
        ));

    // Repair Day 1
    await db.into(db.tasks).insert(TasksCompanion.insert(
          date: day1,
          goalId: 'repair',
          title: 'Theory 90m — V/I/R/continuity/open/short',
          description: const Value(
              'Study voltage, current, resistance, continuity, open vs short. Safety first.'),
          isDayOne: const Value(true),
          sortOrder: const Value(0),
        ));
    await db.into(db.tasks).insert(TasksCompanion.insert(
          date: day1,
          goalId: 'repair',
          title: 'Practical 60m — board photo & unpowered ID',
          description: const Value(
              'Photo board, mark model, inspect damage, identify DC-in/MOSFETs/coils/caps. Unpowered measurements only.'),
          isDayOne: const Value(true),
          sortOrder: const Value(1),
        ));

    await db.into(db.measurementNotebook).insert(
          MeasurementNotebookCompanion.insert(
            date: day1,
            point: 'DC-in continuity (placeholder)',
            value: 'TBD',
            unit: const Value('Ω'),
            notes: const Value('Record first unpowered measurement after inspection.'),
            unpoweredOnly: const Value(true),
          ),
        );

    // Appearance Day 1
    await db.into(db.appearanceRoutines).insert(
          AppearanceRoutinesCompanion.insert(
            date: day1,
            routineType: 'evening',
            checklistJson:
                '["Front photo","Side photo","Note haircut condition","Note beard condition","Identify affordable cleanser","Identify moisturizer","Identify SPF30+","Brush teeth","Floss"]',
            status: const Value('pending'),
          ),
        );
    await db.into(db.groomingRecords).insert(GroomingRecordsCompanion.insert(
          date: day1,
          type: 'haircut',
          details: 'Day 1 baseline haircut condition — update after review.',
          condition: const Value('To assess'),
        ));
    await db.into(db.groomingRecords).insert(GroomingRecordsCompanion.insert(
          date: day1,
          type: 'beard',
          details: 'Day 1 baseline beard condition — update after review.',
          condition: const Value('To assess'),
        ));

    // Cross-goal Day 1 tasks for dashboard
    final day1Tasks = [
      ('fitness', 'Complete Day 1 intro workout', 'Squats, incline push-ups, bridges, rows, dead bugs, plank + warm-up/cooldown'),
      ('fitness', 'Log initial measurements', 'Weight, waist, push-up, squat, plank baselines'),
      ('english', 'Complete baseline assessments', 'Grammar/vocab/listening/reading/speaking/writing (20 each)'),
      ('english', 'Write 150-word intro', 'Save writing sample in assessments'),
      ('appearance', 'Capture front & side photos', 'Private on-device only'),
      ('appearance', 'Start skincare plan', 'Identify affordable cleanser, moisturizer, SPF30+'),
    ];
    var order = 10;
    for (final t in day1Tasks) {
      await db.into(db.tasks).insert(TasksCompanion.insert(
            date: day1,
            goalId: t.$1,
            title: t.$2,
            description: Value(t.$3),
            isDayOne: const Value(true),
            sortOrder: Value(order++),
          ));
    }
  }

  Future<void> _seedDefaultScheduleTemplate() async {
    // Preload schedule for Day 1 (Friday) and generate a few upcoming days.
    final day1 = LevelUpConstants.roadmapStart;
    for (var offset = 0; offset < 14; offset++) {
      final date = day1.add(Duration(days: offset));
      await ensureScheduleForDate(date);
    }
  }

  Future<void> ensureScheduleForDate(DateTime date) async {
    final key = LevelUpDateUtils.formatDate(date);
    final existing = await (db.select(db.scheduleBlocks)
          ..where((t) => t.date.equals(key)))
        .get();
    if (existing.isNotEmpty) return;

    final isSun = date.weekday == DateTime.sunday;
    final blocks = isSun
        ? <(String, String, String, String?)>[
            ('12:00', '12:30', 'Wake & hygiene', null),
            ('12:30', '13:30', 'Optional walk / mobility', 'fitness'),
            ('14:00', '15:00', 'Optional English light review', 'english'),
            ('16:00', '17:00', 'Weekly review', null),
            ('20:30', '21:00', 'Appearance routine', 'appearance'),
            ('03:30', '04:00', 'Sleep prep', null),
          ]
        : <(String, String, String, String?)>[
            ('12:00', '12:30', 'Wake & hygiene', null),
            ('12:30', '13:30',
                'Fitness — ${LevelUpDateUtils.fitnessPlanForWeekday(date.weekday)}',
                'fitness'),
            ('13:30', '14:30', 'Meal & shower', null),
            ('14:30', '15:30', 'English Session 1', 'english'),
            ('15:30', '15:45', 'Break', null),
            ('15:45', '17:15', 'Repair theory', 'repair'),
            ('17:15', '18:15', 'Meal & rest', null),
            ('18:15', '19:15', 'English Session 2', 'english'),
            ('19:15', '19:30', 'Break', null),
            ('19:30', '20:30', 'Repair practical', 'repair'),
            ('20:30', '21:00', 'Appearance', 'appearance'),
            ('21:00', '03:30', 'Personal time', null),
            ('03:30', '04:00', 'Sleep prep', null),
          ];

    var order = 0;
    for (final b in blocks) {
      await db.into(db.scheduleBlocks).insert(ScheduleBlocksCompanion.insert(
            date: key,
            startTime: b.$1,
            endTime: b.$2,
            title: b.$3,
            goalId: Value(b.$4),
            sortOrder: Value(order++),
          ));
    }
  }
}
