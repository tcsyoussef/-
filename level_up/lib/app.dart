import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'providers/app_providers.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'utilities/constants.dart';
import 'widgets/common_widgets.dart';

final _routerProvider = Provider<GoRouter>((ref) => createRouter());

class LevelUpApp extends ConsumerWidget {
  const LevelUpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(bootstrapProvider);
    final router = ref.watch(_routerProvider);

    return MaterialApp.router(
      title: LevelUpConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: router,
      builder: (context, child) {
        return bootstrap.when(
          data: (_) => child ?? const SizedBox.shrink(),
          loading: () => const Scaffold(
            body: LoadingView(message: 'Preparing LEVEL UP…'),
          ),
          error: (e, _) => Scaffold(
            body: ErrorView(
              e,
              onRetry: () => ref.invalidate(bootstrapProvider),
            ),
          ),
        );
      },
    );
  }
}
