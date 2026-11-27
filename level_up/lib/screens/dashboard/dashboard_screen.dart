import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/constants.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final goals = ref.watch(goalsProvider);
    final dayOne = ref.watch(dayOneTasksProvider);
    final schedule = ref.watch(scheduleProvider);
    final profile = ref.watch(profileProvider);
    final selected = ref.watch(selectedDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(LevelUpConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Jump to Day 1',
            onPressed: () {
              ref.read(selectedDateProvider.notifier).state =
                  LevelUpConstants.roadmapStart;
            },
            icon: const Icon(Icons.looks_one_outlined),
          ),
          IconButton(
            tooltip: 'Today',
            onPressed: () {
              final n = DateTime.now();
              ref.read(selectedDateProvider.notifier).state =
                  DateTime(n.year, n.month, n.day);
            },
            icon: const Icon(Icons.today),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(progressProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            progress.when(
              data: (p) => LuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.roadmapState == 'not_started'
                          ? 'Roadmap not started yet'
                          : p.roadmapState == 'completed'
                              ? 'Roadmap complete'
                              : 'Day ${p.dayNumber} / ${p.totalDays}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Selected: ${LevelUpDateUtils.formatDate(selected)} · '
                      '${LevelUpDateUtils.weekdayName(selected.weekday)}',
                      style: const TextStyle(color: AppColors.secondaryText),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProgressRing(
                          percent: p.consistencyScore,
                          label: 'Consistency',
                        ),
                        ProgressRing(
                          percent: p.achievementScore,
                          label: 'Achievements',
                          color: AppColors.fitness,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Today blocks ${p.completedBlocksToday}/${p.totalBlocksToday} · '
                      'Tasks ${p.completedTasksToday}/${p.totalTasksToday}',
                      style: const TextStyle(color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
              loading: () => const LuCard(child: LinearProgressIndicator()),
              error: (e, _) => LuCard(child: Text('Progress error: $e')),
            ),
            const SizedBox(height: 16),
            profile.when(
              data: (prof) => LuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader('Personal profile'),
                    if (prof == null)
                      const Text('No profile')
                    else ...[
                      _kv('Wake / Sleep', '${prof.wakeUp} → ${prof.sleepTime}'),
                      _kv('Daily development', '${prof.dailyDevMinutes} min'),
                      _kv('Training',
                          '${prof.trainingStyle} @ ${prof.trainingLocation}'),
                      _kv('English',
                          '${prof.englishLevel} → ${prof.englishTarget}'),
                      _kv('Repair', prof.repairLevel),
                      _kv('Equipment', prof.equipmentNotes),
                      _kv('Budget / Skin',
                          '${prof.nutritionBudget} · ${prof.skincareStatus}'),
                      _kv('Locale', '${prof.language} · ${prof.currency}'),
                    ],
                  ],
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (e, _) => Text('$e'),
            ),
            const SizedBox(height: 16),
            const SectionHeader('Four goals'),
            goals.when(
              data: (list) => Column(
                children: list
                    .map(
                      (g) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: LuCard(
                          onTap: () => context.go(
                              '/goals/${g.id == 'repair' ? 'repair' : g.id}'),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    goalColor(g.id).withValues(alpha: 0.2),
                                child: Icon(Icons.flag, color: goalColor(g.id)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(g.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    Text(g.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: AppColors.secondaryText),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              loading: () => const LoadingView(),
              error: (e, _) => ErrorView(e),
            ),
            const SizedBox(height: 8),
            const SectionHeader('Day 1 missions'),
            dayOne.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const LuCard(child: Text('Day 1 missions missing'));
                }
                return Column(
                  children: tasks.map((t) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LuCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: t.status == 'completed',
                              activeColor: AppColors.accent,
                              onChanged: (v) async {
                                final db = ref.read(databaseProvider);
                                await (db.update(db.tasks)
                                      ..where((row) => row.id.equals(t.id)))
                                    .write(
                                  TasksCompanion(
                                    status: Value(
                                        v == true ? 'completed' : 'pending'),
                                    completedAt: Value(
                                        v == true ? DateTime.now() : null),
                                  ),
                                );
                                ref.invalidate(progressProvider);
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(t.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  if (t.description != null)
                                    Text(t.description!),
                                  const SizedBox(height: 6),
                                  StatusChip(t.status),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const LoadingView(),
              error: (e, _) => ErrorView(e),
            ),
            const SizedBox(height: 8),
            const SectionHeader('Today\'s schedule preview'),
            schedule.when(
              data: (blocks) {
                if (blocks.isEmpty) {
                  return LuCard(
                    child: Column(
                      children: [
                        const Text('No schedule for selected date.'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(seedServiceProvider)
                                .ensureScheduleForDate(selected);
                          },
                          child: const Text('Generate schedule'),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: blocks.take(6).map((b) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LuCard(
                        onTap: () => context.go('/schedule'),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 84,
                              child: Text(
                                '${b.startTime}\n${b.endTime}',
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(child: Text(b.title)),
                            StatusChip(b.status),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const LoadingView(),
              error: (e, _) => ErrorView(e),
            ),
            const SizedBox(height: 12),
            LuCard(
              onTap: () => context.go('/analytics'),
              child: const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.map_outlined, color: AppColors.accent),
                title: Text('365-day roadmap & analytics'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child:
                Text(k, style: const TextStyle(color: AppColors.secondaryText)),
          ),
          Expanded(child: Text(v)),
        ],
      ),
    );
  }
}
