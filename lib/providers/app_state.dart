import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  int _xp = 1240;
  int _level = 4;

  ThemeMode get themeMode => _themeMode;
  int get xp => _xp;
  int get level => _level;

  void toggleTheme(bool dark) {
    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void addXp(int amount) {
    _xp += amount;
    _level = 1 + (_xp ~/ 350);
    notifyListeners();
  }
}
