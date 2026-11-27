import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

const _statuses = [
  'pending',
  'in_progress',
  'completed',
  'skipped',
  'postponed',
];

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedDateProvider);
    final schedule = ref.watch(scheduleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selected,
                firstDate: DateTime(2026, 11, 1),
                lastDate: DateTime(2027, 12, 31),
              );
              if (picked != null) {
                ref.read(selectedDateProvider.notifier).state =
                    DateTime(picked.year, picked.month, picked.day);
                await ref
                    .read(seedServiceProvider)
                    .ensureScheduleForDate(picked);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: LuCard(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${LevelUpDateUtils.formatDate(selected)} · '
                      '${LevelUpDateUtils.weekdayName(selected.weekday)}'
                      '${LevelUpDateUtils.isSunday(selected) ? ' (Recovery)' : ''}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(selectedDateProvider.notifier).state =
                          selected.subtract(const Duration(days: 1));
                    },
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: () async {
                      final next = selected.add(const Duration(days: 1));
                      ref.read(selectedDateProvider.notifier).state = next;
                      await ref
                          .read(seedServiceProvider)
                          .ensureScheduleForDate(next);
                    },
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: schedule.when(
              data: (blocks) {
                if (blocks.isEmpty) {
                  return EmptyState(
                    'No blocks for this day.',
                    icon: Icons.schedule,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: blocks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final b = blocks[i];
                    return LuCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: goalColor(b.goalId),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(b.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    Text(
                                      '${b.startTime} – ${b.endTime}',
                                      style: const TextStyle(
                                          color: AppColors.secondaryText),
                                    ),
                                  ],
                                ),
                              ),
                              StatusChip(b.status),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _statuses.map((s) {
                              final selectedStatus = b.status == s;
                              return ChoiceChip(
                                label: Text(s.replaceAll('_', ' ')),
                                selected: selectedStatus,
                                onSelected: (_) async {
                                  await _updateStatus(ref, b, s);
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const LoadingView(),
              error: (e, _) => ErrorView(e),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateStatus(
    WidgetRef ref,
    ScheduleBlock block,
    String newStatus,
  ) async {
    final db = ref.read(databaseProvider);
    final old = block.status;
    await (db.update(db.scheduleBlocks)
          ..where((t) => t.id.equals(block.id)))
        .write(ScheduleBlocksCompanion(
      status: Value(newStatus),
      updatedAt: Value(DateTime.now()),
    ));
    await db.into(db.scheduleHistory).insert(ScheduleHistoryCompanion.insert(
          blockId: block.id,
          previousStatus: old,
          newStatus: newStatus,
          reason: const Value('Manual status change'),
        ));
    ref.invalidate(progressProvider);
  }
}
