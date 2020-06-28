import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings with ChangeNotifier {
  int _updateInterval;

  Settings(this._updateInterval);

  int get updateInterval => _updateInterval;

  setUpdateInterval(int interval) {
    _updateInterval = interval;
    notifyListeners();
  }

  saveUpdateInterval() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('update_interval', _updateInterval);
  }
}
