import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/analytics/analytics_screen.dart';
import '../screens/appearance/appearance_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/english/english_screen.dart';
import '../screens/fitness/fitness_screen.dart';
import '../screens/repair/repair_screen.dart';
import '../screens/schedule/schedule_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/shell/app_shell.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/dashboard',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/schedule',
              builder: (context, state) => const ScheduleScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/goals',
              builder: (context, state) => const GoalsHubScreen(),
              routes: [
                GoRoute(
                  path: 'fitness',
                  builder: (context, state) => const FitnessScreen(),
                ),
                GoRoute(
                  path: 'english',
                  builder: (context, state) => const EnglishScreen(),
                ),
                GoRoute(
                  path: 'repair',
                  builder: (context, state) => const RepairScreen(),
                ),
                GoRoute(
                  path: 'appearance',
                  builder: (context, state) => const AppearanceScreen(),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/analytics',
              builder: (context, state) => const AnalyticsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ]),
        ],
      ),
    ],
  );
}

class GoalsHubScreen extends StatelessWidget {
  const GoalsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Fitness', '/goals/fitness', Icons.fitness_center, const Color(0xFF5B8DEF)),
      ('English', '/goals/english', Icons.menu_book, const Color(0xFFB388FF)),
      ('Repair Academy', '/goals/repair', Icons.memory, const Color(0xFFFFB74D)),
      ('Appearance', '/goals/appearance', Icons.face_retouching_natural,
          const Color(0xFF4DD0E1)),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final item = items[i];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFF2A364C)),
            ),
            tileColor: const Color(0xFF182234),
            leading: CircleAvatar(
              backgroundColor: (item.$4).withValues(alpha: 0.2),
              child: Icon(item.$3, color: item.$4),
            ),
            title: Text(item.$1),
            subtitle: const Text('Open module'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(item.$2),
          );
        },
      ),
    );
  }
}
