import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../database/app_database.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final settings = ref.watch(settingsProvider);
    final notifPrefs = ref.watch(notificationPrefsProvider);
    final notificationService = ref.watch(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader('Profile'),
          profile.when(
            data: (p) {
              if (p == null) return const Text('No profile');
              return LuCard(
                child: Column(
                  children: [
                    _editRow(context, 'Wake-up', p.wakeUp, (v) async {
                      await _updateProfile(ref, wakeUp: v);
                    }),
                    _editRow(context, 'Sleep', p.sleepTime, (v) async {
                      await _updateProfile(ref, sleepTime: v);
                    }),
                    _editRow(context, 'English level', p.englishLevel, (v) async {
                      await _updateProfile(ref, englishLevel: v);
                    }),
                    _editRow(context, 'English target', p.englishTarget, (v) async {
                      await _updateProfile(ref, englishTarget: v);
                    }),
                    _editRow(context, 'Nutrition budget', p.nutritionBudget,
                        (v) async {
                      await _updateProfile(ref, nutritionBudget: v);
                    }),
                    _editRow(context, 'Notes', p.notes ?? '', (v) async {
                      await _updateProfile(ref, notes: v);
                    }),
                  ],
                ),
              );
            },
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Notifications'),
          settings.when(
            data: (s) {
              if (s == null) return const SizedBox.shrink();
              return LuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Enable reminders'),
                      subtitle: Text(
                        notificationService.permissionGranted
                            ? 'Permission granted'
                            : 'Permission not granted — reminders will not fire',
                        style: TextStyle(
                          color: notificationService.permissionGranted
                              ? AppColors.accent
                              : AppColors.warning,
                        ),
                      ),
                      value: s.notificationsEnabled,
                      onChanged: (v) async {
                        final db = ref.read(databaseProvider);
                        await (db.update(db.appSettings)
                              ..where((t) => t.id.equals(s.id)))
                            .write(AppSettingsCompanion(
                          notificationsEnabled: Value(v),
                        ));
                        await ref
                            .read(notificationServiceProvider)
                            .syncFromPrefs();
                      },
                    ),
                    notifPrefs.when(
                      data: (prefs) => Column(
                        children: prefs
                            .map(
                              (n) => SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(n.title),
                                subtitle: Text('${n.timeHhMm} · ${n.body}'),
                                value: n.enabled,
                                onChanged: (v) async {
                                  final db = ref.read(databaseProvider);
                                  await (db.update(db.notificationPrefs)
                                        ..where((t) => t.id.equals(n.id)))
                                      .write(NotificationPrefsCompanion(
                                    enabled: Value(v),
                                  ));
                                  await ref
                                      .read(notificationServiceProvider)
                                      .syncFromPrefs();
                                },
                              ),
                            )
                            .toList(),
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, _) => Text('$e'),
                    ),
                  ],
                ),
              );
            },
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(e),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Backup & restore'),
          LuCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.upload_file, color: AppColors.accent),
                  title: const Text('Export backup'),
                  subtitle: const Text('Local JSON with versioning'),
                  onTap: () async {
                    try {
                      final file =
                          await ref.read(backupServiceProvider).exportBackup();
                      await Share.shareXFiles(
                        [XFile(file.path)],
                        text: 'LEVEL UP backup',
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Backup saved: ${file.path}')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Export failed: $e')),
                        );
                      }
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.download, color: AppColors.fitness),
                  title: const Text('Restore backup'),
                  subtitle: const Text('Validates version before import'),
                  onTap: () async {
                    final confirmed = await _confirm(
                      context,
                      'Restore will replace current local data. Continue?',
                    );
                    if (confirmed != true) return;
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['json'],
                    );
                    if (result == null || result.files.single.path == null) {
                      return;
                    }
                    try {
                      final text =
                          await File(result.files.single.path!).readAsString();
                      await ref.read(backupServiceProvider).importBackup(text);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Backup restored')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Restore failed: $e')),
                        );
                      }
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.restart_alt, color: AppColors.danger),
                  title: const Text('Reset & reseed Day 1'),
                  subtitle: const Text('Destructive — confirmation required'),
                  onTap: () async {
                    final confirmed = await _confirm(
                      context,
                      'Delete ALL local data and reseed defaults including Day 1?',
                    );
                    if (confirmed != true) return;
                    await ref.read(seedServiceProvider).resetAndReseed();
                    ref.invalidate(progressProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Database reset complete')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const LuCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Privacy',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  'LEVEL UP is offline-first. No accounts, no ads, no analytics SDKs, no backend. All personal data stays on this device.',
                ),
                SizedBox(height: 8),
                Text('Version 1.0.0 · Personal use'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _editRow(
    BuildContext context,
    String label,
    String value,
    Future<void> Function(String) onSave,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(value.isEmpty ? '—' : value),
      trailing: const Icon(Icons.edit_outlined, size: 18),
      onTap: () async {
        final controller = TextEditingController(text: value);
        final ok = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Edit $label'),
            content: TextField(controller: controller, maxLines: 3),
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
        if (ok == true) await onSave(controller.text.trim());
      },
    );
  }

  Future<void> _updateProfile(
    WidgetRef ref, {
    String? wakeUp,
    String? sleepTime,
    String? englishLevel,
    String? englishTarget,
    String? nutritionBudget,
    String? notes,
  }) async {
    final db = ref.read(databaseProvider);
    final current = await db.select(db.profiles).getSingle();
    await (db.update(db.profiles)..where((t) => t.id.equals(current.id))).write(
      ProfilesCompanion(
        wakeUp: wakeUp != null ? Value(wakeUp) : const Value.absent(),
        sleepTime: sleepTime != null ? Value(sleepTime) : const Value.absent(),
        englishLevel:
            englishLevel != null ? Value(englishLevel) : const Value.absent(),
        englishTarget:
            englishTarget != null ? Value(englishTarget) : const Value.absent(),
        nutritionBudget: nutritionBudget != null
            ? Value(nutritionBudget)
            : const Value.absent(),
        notes: notes != null ? Value(notes) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool?> _confirm(BuildContext context, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Continue')),
        ],
      ),
    );
  }
}
