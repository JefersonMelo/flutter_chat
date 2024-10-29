import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums_utils.dart';

class LoggedConfig extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  LoggedConfig() {
    _loadLoggedInStatus();
  }

  Future<void> _loadLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(EnumsPreferencesUtils.keyLoggedIn.name) ?? false;
    notifyListeners();
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    _loggedIn(value);
    notifyListeners();
  }

  Future<void> _loggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(EnumsPreferencesUtils.keyLoggedIn.name, value);
  }
}
