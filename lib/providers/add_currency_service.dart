import 'dart:convert';

import 'package:cryptotracker/models/response_classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddCurrency with ChangeNotifier {
  String BASEURL = 'https://api.coindesk.com/v1/bpi/supported-currencies.json';
  List<Country> _supportedCountries = [];
  http.Client _httpClient = http.Client();
  List<Country> _countries;

  List<Country> get supportedCountries => _supportedCountries;

  List<Country> get countries => _countries;

  AddCurrency(this._countries);

  bool _loading = false;

  bool get loading => _loading;

  saveCountry(Country country) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (!_countries.contains(country)) {
      _countries.add(country);
      _supportedCountries.remove(country);
      pref.setStringList(
          'countries', _countries.map((e) => e.toString()).toList());
      notifyListeners();
    }
  }

  removeCountry(Country country) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _countries.remove(country);
    pref.setStringList(
        'countries', _countries.map((e) => e.toString()).toList());
    fetchSupportedCountries();
    notifyListeners();
  }

  fetchSupportedCountries() async {
    debugPrint('called');
    _loading = true;
    notifyListeners();
    http.Response res = await _httpClient.get(BASEURL);
    if (res.statusCode == 200) {
      _supportedCountries.clear();
      _supportedCountries.addAll(
          SupportCountriesResponse.fromJson(jsonDecode(res.body)).countries);
      _countries.forEach((element) => _supportedCountries.remove(element));
      _loading = false;

      notifyListeners();
    }
  }
}
