import 'dart:convert';

import 'package:cryptotracker/models/response_classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCurrency with ChangeNotifier {
  String BASEURL = 'https://api.coindesk.com/v1/bpi/supported-currencies.json';
  List<Country> _supportedCountries;
  http.Client _httpClient = http.Client();

  _fetchCountries(String countryCode) async {
    http.Response res = await _httpClient.get(BASEURL);
    if (res.statusCode == 200) {
      _supportedCountries.clear();
      _supportedCountries.addAll(
          SupportCountriesResponse.fromJson(jsonDecode(res.body)).countries);
    }
  }
}
