import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

class RepairScreen extends ConsumerStatefulWidget {
  const RepairScreen({super.key});

  @override
  ConsumerState<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends ConsumerState<RepairScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessons = ref.watch(repairLessonsProvider);
    final equipment = ref.watch(equipmentProvider);
    final components = ref.watch(componentsProvider);
    final exercises = ref.watch(repairExercisesProvider);
    final cases = ref.watch(repairCasesProvider);
    final notebook = ref.watch(measurementNotebookProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Academy'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Lessons'),
            Tab(text: 'Equipment'),
            Tab(text: 'Components'),
            Tab(text: 'Exercises'),
            Tab(text: 'Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          lessons.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                LuCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Safety',
                          style: TextStyle(
                              color: AppColors.danger,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 6),
                      Text(
                        'No voltage injection into unknown circuits. Prefer unpowered measurements. Safety before practical electrical work.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ...list.map(
                  (l) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('M${l.monthIndex + 1} · ${l.title}',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('${l.lessonType}${l.safetyCritical ? ' · SAFETY' : ''}'),
                          const SizedBox(height: 6),
                          Text(l.content),
                          if (l.requiresEquipment)
                            Text('Requires: ${l.requiredEquipment}',
                                style: const TextStyle(color: AppColors.warning)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SectionHeader('Measurement notebook'),
                notebook.when(
                  data: (rows) => Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _addMeasurement,
                        icon: const Icon(Icons.add),
                        label: const Text('Add measurement'),
                      ),
                      const SizedBox(height: 8),
                      ...rows.map(
                        (m) => ListTile(
                          title: Text('${m.point}: ${m.value} ${m.unit ?? ''}'),
                          subtitle: Text('${m.date} · ${m.notes ?? ''}'),
                          leading: Icon(
                            m.unpoweredOnly ? Icons.power_off : Icons.bolt,
                            color: AppColors.repair,
                          ),
                        ),
                      ),
                    ],
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('$e'),
                ),
              ],
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          equipment.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final e = list[i];
                return LuCard(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.name),
                    subtitle: Text(e.owned ? 'Owned' : 'Not owned — related exercises may lock'),
                    value: e.owned,
                    activeColor: AppColors.accent,
                    onChanged: (v) async {
                      final db = ref.read(databaseProvider);
                      await (db.update(db.equipmentItems)
                            ..where((t) => t.id.equals(e.id)))
                          .write(EquipmentItemsCompanion(
                        owned: Value(v),
                        acquiredAt: Value(v ? DateTime.now() : null),
                      ));
                    },
                  ),
                );
              },
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          components.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final c = list[i];
                return LuCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.name, style: Theme.of(context).textTheme.titleMedium),
                      Text(c.description),
                      if (c.notes != null) Text(c.notes!),
                    ],
                  ),
                );
              },
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          exercises.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final e = list[i];
                return LuCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(e.title,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          if (e.locked)
                            const Icon(Icons.lock, color: AppColors.warning),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(e.instructions),
                      if (e.safetyNotes != null)
                        Text(e.safetyNotes!,
                            style: const TextStyle(color: AppColors.danger)),
                      if (e.requiredEquipment != null)
                        Text('Equipment: ${e.requiredEquipment}'),
                    ],
                  ),
                );
              },
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          cases.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ElevatedButton.icon(
                  onPressed: _addCase,
                  icon: const Icon(Icons.add),
                  label: const Text('New repair case'),
                ),
                const SizedBox(height: 12),
                if (list.isEmpty) const EmptyState('No cases yet — document Day 1 board work.'),
                ...list.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${c.model} · ${c.date}',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Symptoms: ${c.symptoms}'),
                          if (c.diagnosis != null) Text('Diagnosis: ${c.diagnosis}'),
                          if (c.workflow != null) Text('Workflow: ${c.workflow}'),
                          if (c.outcome != null) Text('Outcome: ${c.outcome}'),
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
        ],
      ),
    );
  }

  Future<void> _addMeasurement() async {
    final point = TextEditingController();
    final value = TextEditingController();
    final unit = TextEditingController(text: 'Ω');
    final notes = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unpowered measurement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: point, decoration: const InputDecoration(labelText: 'Point')),
            TextField(controller: value, decoration: const InputDecoration(labelText: 'Value')),
            TextField(controller: unit, decoration: const InputDecoration(labelText: 'Unit')),
            TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok != true || point.text.isEmpty) return;
    final db = ref.read(databaseProvider);
    await db.into(db.measurementNotebook).insert(MeasurementNotebookCompanion.insert(
          date: LevelUpDateUtils.formatDate(DateTime.now()),
          point: point.text.trim(),
          value: value.text.trim(),
          unit: Value(unit.text.trim()),
          notes: Value(notes.text.trim().isEmpty ? null : notes.text.trim()),
          unpoweredOnly: const Value(true),
        ));
  }

  Future<void> _addCase() async {
    final model = TextEditingController();
    final symptoms = TextEditingController();
    final diagnosis = TextEditingController();
    final workflow = TextEditingController(
        text: '1. Visual\n2. Unpowered continuity\n3. Document\n4. Stop if unsure');
    final outcome = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Repair case'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: model, decoration: const InputDecoration(labelText: 'Model')),
              TextField(controller: symptoms, decoration: const InputDecoration(labelText: 'Symptoms')),
              TextField(controller: diagnosis, decoration: const InputDecoration(labelText: 'Diagnosis')),
              TextField(controller: workflow, maxLines: 4, decoration: const InputDecoration(labelText: 'Workflow')),
              TextField(controller: outcome, decoration: const InputDecoration(labelText: 'Outcome')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok != true || model.text.isEmpty) return;
    final db = ref.read(databaseProvider);
    await db.into(db.repairCases).insert(RepairCasesCompanion.insert(
          date: LevelUpDateUtils.formatDate(DateTime.now()),
          model: model.text.trim(),
          symptoms: symptoms.text.trim(),
          diagnosis: Value(diagnosis.text.trim().isEmpty ? null : diagnosis.text.trim()),
          workflow: Value(workflow.text.trim()),
          outcome: Value(outcome.text.trim().isEmpty ? null : outcome.text.trim()),
        ));
  }
}
