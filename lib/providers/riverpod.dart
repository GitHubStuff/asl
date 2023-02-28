import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/app_theme.dart';

@immutable
class ThemeModeManager {
  final ThemeMode mode;
  const ThemeModeManager(this.mode);
  void save() => AppTheme.mode = mode;
}

class ThemeModeNotifier extends StateNotifier<ThemeModeManager> {
  ThemeModeNotifier() : super(ThemeModeManager(AppTheme.mode));
  void changeTo({required ThemeMode mode}) => state = ThemeModeManager(mode)..save();
  void changeToLightMode() => state = const ThemeModeManager(ThemeMode.light)..save();
  void changeToDarkMode() => state = const ThemeModeManager(ThemeMode.dark)..save();
  void changeToSystemMode() => state = const ThemeModeManager(ThemeMode.system)..save();
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeModeManager>((_) => ThemeModeNotifier());
