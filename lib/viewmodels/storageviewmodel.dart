import 'package:flash/utils/storagemanager.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StorageViewModel extends BaseViewModel {
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;
  bool darkMode = false;
  StorageViewModel() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'dark';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        darkMode = false;
      } else {
        _themeData = darkTheme;
        darkMode = true;
      }
      notifyListeners();
    });
  }
  void toggleThemeMode() {
    if (darkMode) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    darkMode = true;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    darkMode = false;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
