import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier {
  static const String themeKey = 'isDarkTheme';

  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeViewModel() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(themeKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, _isDark);
  }
}
