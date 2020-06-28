import 'package:cryptotracker/providers/add_currency_service.dart';
import 'package:cryptotracker/providers/setting_service.dart';
import 'package:cryptotracker/providers/tracker_service.dart';
import 'package:cryptotracker/screens/add_currency.dart';
import 'package:cryptotracker/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tracker = Provider.of<Tracker>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Consumer<Tracker>(builder: (_, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () async {
                    tracker.cancelTimer();
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          child: SettingsScreen(),
                          create: (_) => Settings(value.updateInterval),
                        ),
                      ),
                    );
                    tracker.initialize();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Crypto Tracker',
                    textScaleFactor: 1.2,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    tracker.cancelTimer();
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          child: AddCurrencyScreen(),
                          create: (_) => AddCurrency(value.countries)
                            ..fetchSupportedCountries(),
                        ),
                      ),
                    );
                    tracker.initialize();
                  },
                ),
              ],
            );
          }),
          Consumer<Tracker>(builder: (_, value, __) {
            if (value.currentPrices.length > 0 && !value.loading)
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final currency = value.currentPrices.keys.toList()[index];
                  return Card(
                    elevation: 20,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(value.currentPrices[currency].bpi.country
                                .countryName),
                            Text(value.currentPrices[currency].bpi.rate
                                .toString()),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => value.removeCountry(
                                  value.currentPrices[currency].bpi.country),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Last Updated'),
                            Text(value.currentPrices[currency].time
                                .toLocal()
                                .toIso8601String()),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: value.currentPrices.length,
              );
            else if (value.currentPrices.length == 0 && !value.loading)
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Press the add button at the top right corner to add a currency'),
              );
            return CircularProgressIndicator();
          }),
        ],
      ),
    );
  }
}
