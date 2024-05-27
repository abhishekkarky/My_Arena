import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>(
  (ref) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system);

  Future<SharedPreferences> _getStorage() async {
    return await SharedPreferences.getInstance();
  }

  void toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    final storage = await _getStorage();
    storage.setBool("isDark", state == ThemeMode.dark);
  }

  Future<void> init() async {
    final storage = await _getStorage();
    final isDark = storage.getBool("isDark");
    if (isDark != null) {
      state = isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }
}
