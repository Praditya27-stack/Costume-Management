import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const _themeKey = "isDarkTheme";

  // Save theme preference
  Future<void> setDarkTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }

  // Load theme preference
  Future<bool> getDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Default ke false (tema terang)
  }
}
