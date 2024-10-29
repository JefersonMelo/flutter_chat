import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums_utils.dart';

class UserPrefsConfig extends ChangeNotifier {
  bool _isDarkMode = false;
  String _userName = '';
  String _email = '';
  String _imagePath = '';

  bool get isDarkMode => _isDarkMode;
  String get userName => _userName;
  String get email => _email;
  String get image => _imagePath;

  UserPrefsConfig() {
    _loadPreferences();
    getUserValues();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(EnumsPreferencesUtils.keyDarkMode.name) ?? false;
    notifyListeners();
  }

  void toggleTheme(bool value) async {
    _isDarkMode = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(EnumsPreferencesUtils.keyDarkMode.name, value);
    notifyListeners();
  }

  Future<void> getUserValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imagePath = prefs.getString(EnumsPreferencesUtils.keyPathImage.name) ?? '';
    _userName = prefs.getString(EnumsPreferencesUtils.keyUserName.name) ?? '';
    _email = prefs.getString(EnumsPreferencesUtils.keyEmail.name) ?? '';
    notifyListeners();
  }
}
