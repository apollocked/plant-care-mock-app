import 'package:flutter/material.dart';
import 'package:mock_plant_care_app/services/storage_service.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeViewModel(this._storageService);

  final StorageService _storageService;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> loadThemeMode() async {
    final String? mode = _storageService.getThemeMode();
    if (mode == ThemeMode.dark.name) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _storageService.saveThemeMode(_themeMode.name);
    notifyListeners();
  }
}
