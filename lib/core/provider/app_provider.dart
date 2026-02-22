import 'package:evently/core/route/get_helper.dart';
import 'package:evently/core/widgets/change_selected_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  SelectedType languageType = SelectedType.button1;
  SelectedType themeType = SelectedType.button1;

  ThemeMode themeMode = ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  String language = 'en';

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saveLanguage = prefs.getString("language");
    if (saveLanguage != null) {
      language = saveLanguage;
    }
    if (language == 'en') {
      languageType = SelectedType.button1;
    } else {
      languageType = SelectedType.button2;
    }
    notifyListeners();
  }

  Future<void> changeLanguage(SelectedType selected) async {
    languageType = selected;
    if (selected == SelectedType.button1) {
      language = 'en';
    } else {
      language = 'ar';
    }
    await saveLanguage();
    notifyListeners();
  }

  Future<void> saveLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", language);
  }

  void loadTheme() {
    String? saveTheme = GetHelper.prefs.getString("theme") ?? "light";

    if (saveTheme == "light") {
      themeMode = ThemeMode.light;
      themeType = SelectedType.button1;
    } else {
      themeMode = ThemeMode.dark;
      themeType = SelectedType.button2;
    }
    notifyListeners();
  }

  void changeTheme(SelectedType selected) {
    themeType = selected;
    if (selected == SelectedType.button1) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    saveTheme();
    notifyListeners();
  }

  Future<void> saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "theme",
      themeMode == ThemeMode.light ? "light" : "dark",
    );
  }
}
