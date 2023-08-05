import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/shared.dart';


final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
    final keyValueStorageService = KeyValueStorageServiceImpl();
    
  return SettingsNotifier(keyValueStorageService: keyValueStorageService);
});

class SettingsNotifier extends StateNotifier<SettingsState> {
    final KeyValueStorageService keyValueStorageService;
  SettingsNotifier({required this.keyValueStorageService}) : super(SettingsState()) {
    checkConfig();
  }

  Future<void> checkConfig() async {
    final bool darkMode = await keyValueStorageService.getValue<bool>('darkMode') ?? false;

    state = state.copyWith(
      isDarkMode: darkMode,
    );
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    keyValueStorageService.setKeyValue('darkMode', state.isDarkMode);
  }
}

class SettingsState {
  final bool isDarkMode;
  final Color colorSchemeSeed;

  SettingsState({
    this.isDarkMode = false,
    this.colorSchemeSeed = const Color(0xFFff5d5f),
  });

  copyWith({
    bool? isDarkMode,
    Color? colorSchemeSeed,
  }) =>
      SettingsState(
          isDarkMode: isDarkMode ?? this.isDarkMode,
          colorSchemeSeed: colorSchemeSeed ?? this.colorSchemeSeed);
}
