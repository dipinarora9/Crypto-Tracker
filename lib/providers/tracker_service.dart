import 'dart:async';
import 'dart:convert';

import 'package:cryptotracker/models/response_classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Tracker with ChangeNotifier {
  String BASEURL = 'https://api.coindesk.com/v1/bpi/currentprice/';
  Map<String, CurrentPriceResponse> _currentPrices = {};
  List<Country> _countries;
  http.Client _httpClient = http.Client();
  int _updateInterval;
  Timer _updateTimer;
  bool _loading = false;

  bool get loading => _loading;

  int get updateInterval => _updateInterval;

  List<Country> get countries => _countries;

  Map<String, CurrentPriceResponse> get currentPrices => _currentPrices;

  initialize() {
    _loading = true;
    notifyListeners();
    _getPrefs().then((_) {
      fetchAll();
      startTimer();
    });
  }

  fetchAll() {
    for (Country country in _countries) {
      _fetchBPI(country.currency);
    }
  }

  startTimer() {
    if (_countries.length > 0)
      _updateTimer = Timer.periodic(Duration(minutes: _updateInterval), (_) {
        debugPrint('updating');
        fetchAll();
      });
  }

  cancelTimer() {
    if (_updateTimer != null && _updateTimer.isActive) _updateTimer.cancel();
  }

  Future<void> _getPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var c = pref.getStringList('countries') ?? [];
    _countries = c.map((e) => Country.fromString(e)).toList();
    _updateInterval = pref.getInt('update_interval') ?? 1;
  }

  removeCountry(Country country) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _countries.remove(country);
    _currentPrices.remove(country.currency);
    pref.setStringList(
        'countries', _countries.map((e) => e.toString()).toList());
    notifyListeners();
  }

  _fetchBPI(String currency) async {
    http.Response res = await _httpClient.get(BASEURL + currency + '.json');
    if (res.statusCode == 200) {
      _currentPrices[currency] =
          CurrentPriceResponse.fromJson(jsonDecode(res.body));
      _loading = false;
      notifyListeners();
    }
  }
}
