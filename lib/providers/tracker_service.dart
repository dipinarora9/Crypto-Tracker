import 'dart:convert';

import 'package:cryptotracker/models/response_classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tracker with ChangeNotifier {
  String BASEURL = 'https://api.coindesk.com/v1/bpi/currentprice/';
  Map<String, CurrentPriceResponse> _currentPrices;
  http.Client _httpClient = http.Client();

  _fetchBPI(String countryCode) async {
    http.Response res = await _httpClient.get(BASEURL + countryCode + '.json');
    if (res.statusCode == 200)
      _currentPrices[countryCode] =
          CurrentPriceResponse.fromJson(jsonDecode(res.body));
  }
}
