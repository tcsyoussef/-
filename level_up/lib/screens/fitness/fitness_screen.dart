import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

class FitnessScreen extends ConsumerStatefulWidget {
  const FitnessScreen({super.key});

  @override
  ConsumerState<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends ConsumerState<FitnessScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  Timer? _timer;
  int _restLeft = 0;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabs.dispose();
    super.dispose();
  }

  void _startRest(int seconds) {
    _timer?.cancel();
    setState(() => _restLeft = seconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_restLeft <= 1) {
        t.cancel();
        setState(() => _restLeft = 0);
      } else {
        setState(() => _restLeft--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessions = ref.watch(workoutSessionsProvider);
    final exercises = ref.watch(exercisesProvider);
    final measurements = ref.watch(measurementsProvider);
    final nutrition = ref.watch(nutritionProvider);
    final selected = ref.watch(selectedDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Workout'),
            Tab(text: 'Library'),
            Tab(text: 'Measurements'),
            Tab(text: 'Nutrition'),
          ],
        ),
        actions: [
          if (_restLeft > 0)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  'Rest $_restLeft s',
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          sessions.when(
            data: (list) {
              if (list.isEmpty) return const EmptyState('No workouts yet');
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final s = list[i];
                  return LuCard(
                    onTap: () => _openSession(s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.planName,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text('${s.date} · ${LevelUpDateUtils.fitnessPlanForWeekday(selected.weekday)}'),
                        const SizedBox(height: 8),
                        StatusChip(s.status),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          exercises.when(
            data: (list) {
              final grouped = <String, List<Exercise>>{};
              for (final e in list) {
                grouped.putIfAbsent(e.category, () => []).add(e);
              }
              return ListView(
                padding: const EdgeInsets.all(16),
                children: grouped.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(entry.key.replaceAll('_', ' ').toUpperCase()),
                      ...entry.value.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: LuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Text(e.instructions),
                                const SizedBox(height: 8),
                                Text(
                                  '${e.defaultSets} sets · ${e.defaultReps} · rest ${e.restSeconds}s',
                                  style: const TextStyle(
                                      color: AppColors.secondaryText),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => _startRest(e.restSeconds),
                                    child: const Text('Start rest timer'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          measurements.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ElevatedButton.icon(
                  onPressed: () => _editMeasurement(null),
                  icon: const Icon(Icons.add),
                  label: const Text('Log measurement'),
                ),
                const SizedBox(height: 12),
                if (list.isEmpty) const EmptyState('No measurements yet'),
                ...list.map(
                  (m) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      onTap: () => _editMeasurement(m),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.date,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            'Weight: ${m.weightKg ?? '—'} kg · Waist: ${m.waistCm ?? '—'} cm',
                          ),
                          Text(
                            'Push-ups: ${m.pushUps ?? '—'} · Squats: ${m.squats ?? '—'} · Plank: ${m.plankSeconds ?? '—'}s',
                          ),
                          if (m.notes != null) Text(m.notes!),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          nutrition.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final n = list[i];
                return LuCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n.title,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text(n.content),
                    ],
                  ),
                );
              },
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
        ],
      ),
    );
  }

  Future<void> _openSession(WorkoutSession session) async {
    final db = ref.read(databaseProvider);
    final sets = await (db.select(db.workoutSets)
          ..where((t) => t.sessionId.equals(session.id)))
        .get();
    final exercises = await db.select(db.exercises).get();
    final byId = {for (final e in exercises) e.id: e};

    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (context, controller) {
            return ListView(
              controller: controller,
              padding: const EdgeInsets.all(16),
              children: [
                Text(session.planName,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(session.notes ?? ''),
                const SizedBox(height: 12),
                ...sets.map((s) {
                  final ex = byId[s.exerciseId];
                  return CheckboxListTile(
                    value: s.completed,
                    title: Text('${ex?.name ?? 'Exercise'} · set ${s.setNumber}'),
                    subtitle: Text('Target ${s.targetReps}'),
                    onChanged: (v) async {
                      await (db.update(db.workoutSets)
                            ..where((t) => t.id.equals(s.id)))
                          .write(WorkoutSetsCompanion(
                        completed: Value(v ?? false),
                        actualReps: Value(s.targetReps),
                      ));
                      if (v == true) _startRest(ex?.restSeconds ?? 60);
                      if (context.mounted) Navigator.pop(context);
                      _openSession(session);
                    },
                  );
                }),
                ElevatedButton(
                  onPressed: () async {
                    await (db.update(db.workoutSessions)
                          ..where((t) => t.id.equals(session.id)))
                        .write(WorkoutSessionsCompanion(
                      status: const Value('completed'),
                      completedAt: Value(DateTime.now()),
                    ));
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text('Mark workout complete'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _editMeasurement(Measurement? existing) async {
    final weight = TextEditingController(text: existing?.weightKg?.toString() ?? '');
    final waist = TextEditingController(text: existing?.waistCm?.toString() ?? '');
    final push = TextEditingController(text: existing?.pushUps?.toString() ?? '');
    final squat = TextEditingController(text: existing?.squats?.toString() ?? '');
    final plank =
        TextEditingController(text: existing?.plankSeconds?.toString() ?? '');
    final notes = TextEditingController(text: existing?.notes ?? '');

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'New measurement' : 'Edit measurement'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: weight, decoration: const InputDecoration(labelText: 'Weight kg'), keyboardType: TextInputType.number),
              TextField(controller: waist, decoration: const InputDecoration(labelText: 'Waist cm'), keyboardType: TextInputType.number),
              TextField(controller: push, decoration: const InputDecoration(labelText: 'Push-ups'), keyboardType: TextInputType.number),
              TextField(controller: squat, decoration: const InputDecoration(labelText: 'Squats'), keyboardType: TextInputType.number),
              TextField(controller: plank, decoration: const InputDecoration(labelText: 'Plank seconds'), keyboardType: TextInputType.number),
              TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );

    if (ok != true) return;
    final db = ref.read(databaseProvider);
    final date = LevelUpDateUtils.formatDate(ref.read(selectedDateProvider));
    final companion = MeasurementsCompanion(
      date: Value(existing?.date ?? date),
      weightKg: Value(double.tryParse(weight.text)),
      waistCm: Value(double.tryParse(waist.text)),
      pushUps: Value(int.tryParse(push.text)),
      squats: Value(int.tryParse(squat.text)),
      plankSeconds: Value(int.tryParse(plank.text)),
      notes: Value(notes.text.isEmpty ? null : notes.text),
    );
    if (existing == null) {
      await db.into(db.measurements).insert(companion);
    } else {
      await (db.update(db.measurements)..where((t) => t.id.equals(existing.id)))
          .write(companion);
    }
  }
}
