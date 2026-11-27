import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

class AppearanceScreen extends ConsumerStatefulWidget {
  const AppearanceScreen({super.key});

  @override
  ConsumerState<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends ConsumerState<AppearanceScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routines = ref.watch(appearanceRoutinesProvider);
    final products = ref.watch(appearanceProductsProvider);
    final grooming = ref.watch(groomingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Routines'),
            Tab(text: 'Products'),
            Tab(text: 'Grooming'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          routines.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ElevatedButton.icon(
                  onPressed: () => _createRoutine('evening'),
                  icon: const Icon(Icons.add),
                  label: const Text('Add evening routine'),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => _createRoutine('morning'),
                  icon: const Icon(Icons.wb_sunny_outlined),
                  label: const Text('Add morning routine'),
                ),
                const SizedBox(height: 12),
                if (list.isEmpty) const EmptyState('No routines yet'),
                ...list.map((r) {
                  final items = (jsonDecode(r.checklistJson) as List)
                      .map((e) => e.toString())
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LuCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${r.date} · ${r.routineType}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              StatusChip(r.status),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...items.map((item) => Text('• $item')),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: r.status == 'completed'
                                  ? null
                                  : () async {
                                      final db = ref.read(databaseProvider);
                                      await (db.update(db.appearanceRoutines)
                                            ..where((t) => t.id.equals(r.id)))
                                          .write(AppearanceRoutinesCompanion(
                                        status: const Value('completed'),
                                        completedAt: Value(DateTime.now()),
                                      ));
                                    },
                              child: const Text('Complete'),
                            ),
                          ),
                          const Text(
                            'Photos stay private on device. Capture front/side via your gallery workflow and note paths in grooming records.',
                            style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          products.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final p = list[i];
                return LuCard(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(p.name),
                    subtitle: Text(
                      '${p.category} · ~${p.priceMad?.toStringAsFixed(0) ?? '?'} MAD'
                      '${p.notes != null ? '\n${p.notes}' : ''}',
                    ),
                    value: p.owned,
                    onChanged: (v) async {
                      final db = ref.read(databaseProvider);
                      await (db.update(db.appearanceProducts)
                            ..where((t) => t.id.equals(p.id)))
                          .write(AppearanceProductsCompanion(owned: Value(v)));
                    },
                  ),
                );
              },
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          grooming.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ElevatedButton.icon(
                  onPressed: _addGrooming,
                  icon: const Icon(Icons.add),
                  label: const Text('Add grooming record'),
                ),
                const SizedBox(height: 12),
                ...list.map(
                  (g) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('${g.type} · ${g.date}'),
                        subtitle: Text('${g.details}\nCondition: ${g.condition ?? '—'}'),
                        isThreeLine: true,
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

  Future<void> _createRoutine(String type) async {
    final checklist = type == 'morning'
        ? [
            'Wash face',
            'Moisturizer if owned',
            'SPF if daytime outdoor',
            'Brush teeth',
          ]
        : [
            'Cleanse',
            'Moisturizer',
            'Brush teeth',
            'Floss',
            'Quick beard/hair check',
          ];
    final db = ref.read(databaseProvider);
    await db.into(db.appearanceRoutines).insert(AppearanceRoutinesCompanion.insert(
          date: LevelUpDateUtils.formatDate(DateTime.now()),
          routineType: type,
          checklistJson: jsonEncode(checklist),
        ));
  }

  Future<void> _addGrooming() async {
    final type = TextEditingController(text: 'haircut');
    final details = TextEditingController();
    final condition = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Grooming record'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: type, decoration: const InputDecoration(labelText: 'Type (haircut/beard/dental)')),
            TextField(controller: details, decoration: const InputDecoration(labelText: 'Details')),
            TextField(controller: condition, decoration: const InputDecoration(labelText: 'Condition')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok != true) return;
    final db = ref.read(databaseProvider);
    await db.into(db.groomingRecords).insert(GroomingRecordsCompanion.insert(
          date: LevelUpDateUtils.formatDate(DateTime.now()),
          type: type.text.trim(),
          details: details.text.trim(),
          condition: Value(condition.text.trim().isEmpty ? null : condition.text.trim()),
        ));
  }
}
