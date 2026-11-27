import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../utilities/date_utils.dart';
import '../../widgets/common_widgets.dart';

class EnglishScreen extends ConsumerStatefulWidget {
  const EnglishScreen({super.key});

  @override
  ConsumerState<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends ConsumerState<EnglishScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessons = ref.watch(englishLessonsProvider);
    final vocab = ref.watch(vocabProvider);
    final assessments = ref.watch(englishAssessmentsProvider);
    final sessions = ref.watch(englishSessionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('English'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Lessons'),
            Tab(text: 'Vocab'),
            Tab(text: 'Assessments'),
            Tab(text: 'Sessions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          lessons.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final l = list[i];
                return LuCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('M${l.monthIndex + 1} W${l.weekIndex} · ${l.theme}',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text('Grammar: ${l.grammarFocus}'),
                      Text('Vocab: ${l.vocabFocus}'),
                      const SizedBox(height: 8),
                      Text(l.content),
                    ],
                  ),
                );
              },
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          vocab.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ElevatedButton.icon(
                  onPressed: _addVocab,
                  icon: const Icon(Icons.add),
                  label: const Text('Add vocab'),
                ),
                const SizedBox(height: 12),
                if (list.isEmpty)
                  const EmptyState('Vocab notebook is empty — add words daily.'),
                ...list.map(
                  (v) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(v.word),
                        subtitle: Text('${v.meaning}\n${v.example ?? ''}'),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.replay),
                          tooltip: 'Mark reviewed',
                          onPressed: () async {
                            final db = ref.read(databaseProvider);
                            await (db.update(db.vocabEntries)
                                  ..where((t) => t.id.equals(v.id)))
                                .write(VocabEntriesCompanion(
                              revisionCount: Value(v.revisionCount + 1),
                              lastReviewed: Value(DateTime.now()),
                            ));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          assessments.when(
            data: (list) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Manual scoring only — no speech AI. Day 1 baselines included.',
                  style: TextStyle(color: AppColors.secondaryText),
                ),
                const SizedBox(height: 12),
                ...list.map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LuCard(
                      onTap: () => _editAssessment(a),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${a.type.toUpperCase()} · ${a.date}',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Score: ${a.score}/${a.maxScore}'),
                          if (a.notes != null) Text(a.notes!),
                          if (a.writingSample != null) ...[
                            const SizedBox(height: 6),
                            Text(a.writingSample!,
                                maxLines: 4, overflow: TextOverflow.ellipsis),
                          ],
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
          sessions.when(
            data: (list) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final s = list[i];
                return LuCard(
                  onTap: () => _editSession(s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${s.date} · Session ${s.sessionNumber}',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        'G${s.grammarMinutes} V${s.vocabMinutes} L${s.listeningMinutes} '
                        'R${s.readingMinutes} S${s.speakingMinutes} W${s.writingMinutes}',
                      ),
                      const SizedBox(height: 6),
                      StatusChip(s.status),
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

  Future<void> _addVocab() async {
    final word = TextEditingController();
    final meaning = TextEditingController();
    final example = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New vocab'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: word, decoration: const InputDecoration(labelText: 'Word')),
            TextField(controller: meaning, decoration: const InputDecoration(labelText: 'Meaning')),
            TextField(controller: example, decoration: const InputDecoration(labelText: 'Example')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok != true || word.text.trim().isEmpty) return;
    final db = ref.read(databaseProvider);
    await db.into(db.vocabEntries).insert(VocabEntriesCompanion.insert(
          word: word.text.trim(),
          meaning: meaning.text.trim(),
          example: Value(example.text.trim().isEmpty ? null : example.text.trim()),
          date: LevelUpDateUtils.formatDate(DateTime.now()),
        ));
  }

  Future<void> _editAssessment(EnglishAssessment a) async {
    final score = TextEditingController(text: '${a.score}');
    final notes = TextEditingController(text: a.notes ?? '');
    final writing = TextEditingController(text: a.writingSample ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${a.type}'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: score,
                decoration: InputDecoration(labelText: 'Score / ${a.maxScore}'),
                keyboardType: TextInputType.number,
              ),
              TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
              if (a.type == 'writing')
                TextField(
                  controller: writing,
                  maxLines: 6,
                  decoration: const InputDecoration(labelText: 'Writing sample'),
                ),
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
    await (db.update(db.englishAssessments)..where((t) => t.id.equals(a.id)))
        .write(EnglishAssessmentsCompanion(
      score: Value(int.tryParse(score.text) ?? a.score),
      notes: Value(notes.text),
      writingSample: Value(writing.text.isEmpty ? null : writing.text),
    ));
  }

  Future<void> _editSession(EnglishSession s) async {
    final g = TextEditingController(text: '${s.grammarMinutes}');
    final v = TextEditingController(text: '${s.vocabMinutes}');
    final l = TextEditingController(text: '${s.listeningMinutes}');
    final r = TextEditingController(text: '${s.readingMinutes}');
    final sp = TextEditingController(text: '${s.speakingMinutes}');
    final w = TextEditingController(text: '${s.writingMinutes}');
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Session ${s.sessionNumber} minutes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: g, decoration: const InputDecoration(labelText: 'Grammar')),
              TextField(controller: v, decoration: const InputDecoration(labelText: 'Vocab')),
              TextField(controller: l, decoration: const InputDecoration(labelText: 'Listening')),
              TextField(controller: r, decoration: const InputDecoration(labelText: 'Reading')),
              TextField(controller: sp, decoration: const InputDecoration(labelText: 'Speaking')),
              TextField(controller: w, decoration: const InputDecoration(labelText: 'Writing')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save & complete')),
        ],
      ),
    );
    if (ok != true) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.englishSessions)..where((t) => t.id.equals(s.id)))
        .write(EnglishSessionsCompanion(
      grammarMinutes: Value(int.tryParse(g.text) ?? 0),
      vocabMinutes: Value(int.tryParse(v.text) ?? 0),
      listeningMinutes: Value(int.tryParse(l.text) ?? 0),
      readingMinutes: Value(int.tryParse(r.text) ?? 0),
      speakingMinutes: Value(int.tryParse(sp.text) ?? 0),
      writingMinutes: Value(int.tryParse(w.text) ?? 0),
      status: const Value('completed'),
    ));
  }
}
