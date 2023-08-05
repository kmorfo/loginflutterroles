import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/config/config.dart';
import 'src/features/settings/settings.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(settingsProvider);
    final appRouter = ref.watch(goRouterProvier);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(
        isDarkmode: config.isDarkMode,
        colorSeed: config.colorSchemeSeed,
      ).getTheme(),
      title: 'Login App',
    );
  }
}
