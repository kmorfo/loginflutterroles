import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/auth.dart';
import '../../settings.dart';


class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    final isDarkMode = ref.watch(settingsProvider).isDarkMode;
    final auth = ref.watch(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('LoginApp'),
        actions: [
          IconButton(
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Dark Mode', style: textStyles.headlineMedium),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, size: 50),
                const SizedBox(width: 16),
                Switch.adaptive(
                    value: isDarkMode,
                    onChanged: (value) => ref.read(settingsProvider.notifier).toggleDarkMode()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
