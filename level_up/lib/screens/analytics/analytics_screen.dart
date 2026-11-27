import 'package:drift/drift.dart' show Value;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/constants.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roadmap = ref.watch(roadmapProvider);
    final progress = ref.watch(progressProvider);
    final assessments = ref.watch(englishAssessmentsProvider);
    final measurements = ref.watch(measurementsProvider);
    final achievements = ref.watch(achievementsProvider);
    final reviews = ref.watch(reviewsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics & Roadmap')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          progress.when(
            data: (p) => LuCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day ${p.dayNumber}/${p.totalDays} · ${p.roadmapState}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${LevelUpDateUtils.formatDate(LevelUpConstants.roadmapStart)} → '
                    '${LevelUpDateUtils.formatDate(LevelUpConstants.roadmapEnd)}',
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: p.dayNumber / p.totalDays,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Consistency ${p.consistencyScore.toStringAsFixed(1)}% · '
                    'Achievements ${p.achievementScore.toStringAsFixed(1)}%',
                  ),
                ],
              ),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('$e'),
          ),
          const SizedBox(height: 16),
          const SectionHeader('12-month roadmap'),
          roadmap.when(
            data: (months) => Column(
              children: months.map((m) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: LuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q${m.quarter} · ${m.title}',
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(m.focus,
                            style: const TextStyle(color: AppColors.accent)),
                        const SizedBox(height: 4),
                        Text(m.objectives),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          const SizedBox(height: 16),
          const SectionHeader('English assessment chart'),
          assessments.when(
            data: (list) {
              final scored = list.where((a) => a.score > 0).toList();
              if (scored.isEmpty) {
                return const LuCard(
                  child: Text(
                    'No scored assessments yet. Fill Day 1 baselines to populate this chart.',
                  ),
                );
              }
              return LuCard(
                child: SizedBox(
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: true, reservedSize: 28),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();
                              if (i < 0 || i >= scored.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  scored[i].type.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        for (var i = 0; i < scored.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: scored[i].score.toDouble(),
                                color: AppColors.english,
                                width: 14,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Body metrics'),
          measurements.when(
            data: (list) {
              final withWeight = list
                  .where((m) => m.weightKg != null)
                  .toList()
                  .reversed
                  .toList();
              if (withWeight.isEmpty) {
                return const LuCard(
                    child: Text('Log weight to see the fitness trend.'));
              }
              return LuCard(
                child: SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: true),
                      titlesData: const FlTitlesData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: AppColors.fitness,
                          barWidth: 3,
                          spots: [
                            for (var i = 0; i < withWeight.length; i++)
                              FlSpot(i.toDouble(), withWeight[i].weightKg!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Achievements'),
          achievements.when(
            data: (list) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: list
                  .map(
                    (a) => Chip(
                      avatar: Icon(
                        a.unlocked ? Icons.emoji_events : Icons.lock_outline,
                        size: 16,
                        color: a.unlocked
                            ? AppColors.accent
                            : AppColors.secondaryText,
                      ),
                      label: Text(a.title),
                    ),
                  )
                  .toList(),
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Reviews'),
          reviews.when(
            data: (list) => Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _addReview(ref, context),
                  icon: const Icon(Icons.rate_review_outlined),
                  label: const Text('Write weekly/monthly review'),
                ),
                const SizedBox(height: 8),
                if (list.isEmpty)
                  const LuCard(
                      child: Text(
                          'No reviews yet. Sundays prompt weekly review.')),
                ...list.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${r.type} · ${r.date}',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(r.content),
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

  Future<void> _addReview(WidgetRef ref, BuildContext context) async {
    final type = TextEditingController(
        text: LevelUpDateUtils.isSunday() ? 'weekly' : 'monthly');
    final content = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: type,
                decoration: const InputDecoration(labelText: 'Type')),
            TextField(
                controller: content,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Content')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save')),
        ],
      ),
    );
    if (ok != true || content.text.trim().isEmpty) return;
    final db = ref.read(databaseProvider);
    final progress = await ref.read(progressServiceProvider).snapshot();
    await db.into(db.reviews).insert(ReviewsCompanion.insert(
          date: LevelUpDateUtils.formatDate(DateTime.now()),
          type: type.text.trim(),
          content: content.text.trim(),
          consistencyScore: Value(progress.consistencyScore),
          achievementScore: Value(progress.achievementScore),
        ));
  }
}
