import 'package:flutter/material.dart';
import 'theme_preference.dart';

class ThemeNotifier extends ChangeNotifier {
  final ThemePreference _themePreference = ThemePreference();
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier() {
    _loadTheme();
  }

  void _loadTheme() async {
    _isDarkTheme = await _themePreference.getDarkTheme();
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _themePreference.setDarkTheme(_isDarkTheme);
    notifyListeners();
  }
}