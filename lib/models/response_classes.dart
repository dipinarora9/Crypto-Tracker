class BPI {
  Country _country;
  double _rate;

  BPI.fromJson(Map<String, dynamic> json)
      : _country = Country(json['code'], json['description']),
        _rate = json['rate_float'];

  double get rate => _rate;

  Country get country => _country;
}

class CurrentPriceResponse {
  DateTime _time;
  BPI _bpi;

  CurrentPriceResponse.fromJson(Map<String, dynamic> json) {
    _time = DateTime.parse(json['time']['updatedISO']);
    if (json['bpi'].length > 0) {
      json['bpi'].remove('USD');
    }
    _bpi = BPI.fromJson(json['bpi'][json['bpi'].keys.first]);
  }

  DateTime get time => _time;

  BPI get bpi => _bpi;
}

class Country {
  String _currency;
  String _countryName;

  Country.fromString(String s)
      : _countryName = s.split('-')[0].trim(),
        _currency = s.split('-')[1].trim();

  Country(String currency, String country)
      : _countryName = country,
        _currency = currency;

  Country.fromJson(Map<String, dynamic> json)
      : _countryName = json['country'],
        _currency = json['currency'];

  String get currency => _currency;

  String get countryName => _countryName;

  @override
  String toString() {
    return '$_countryName - $_currency';
  }
}

class SupportCountriesResponse {
  List<Country> _supportedCountries = [];

  List<Country> get countries => _supportedCountries;

  SupportCountriesResponse.fromJson(List json) {
    json.forEach(
        (element) => _supportedCountries.add(Country.fromJson(element)));
  }
}
