import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  final String _themeKey = 'app_theme';

  Future<void> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);

    final theme = switch (themeString) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    emit(theme);
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
    emit(mode);
  }

  bool isLightTheme(Brightness brightness) {
    switch (state) {
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
      case ThemeMode.system:
        return brightness == Brightness.light;
      }
  }

}

extension ThemeModeExtension on ThemeMode {
  String get name {
    return switch (this) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
  }
}
