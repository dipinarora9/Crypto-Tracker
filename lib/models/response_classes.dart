class BPI {
  String _code;
  double _rate;
  String _description;

  BPI.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _rate = json['rate_float'];
    _description = json['description'];
  }

  String get code => _code;

  double get rate => _rate;

  String get description => _description;
}

class CurrentPriceResponse {
  DateTime _time;
  Map<String, BPI> _bpi;

  CurrentPriceResponse.fromJson(Map<String, dynamic> json) {
    _time = DateTime.parse(json['time']['updatedISO']);
    json['bpi'].forEach((k, v) => _bpi[k] = BPI.fromJson(v));
  }

  DateTime get time => _time;

  Map<String, BPI> get bpi => _bpi;
}

class Country {
  String _currency;
  String _country;

  Country.fromJson(Map<String, dynamic> json) {
    _country = json['country'];
    _currency = json['currency'];
  }

  String get currency => _currency;

  String get country => _country;
}

class SupportCountriesResponse {
  List<Country> _supportedCountries;

  List<Country> get countries => _supportedCountries;

  SupportCountriesResponse.fromJson(List json) {
    json.forEach(
        (element) => _supportedCountries.add(Country.fromJson(element)));
  }
}
