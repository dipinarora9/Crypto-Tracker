import 'package:cryptotracker/providers/add_currency_service.dart';
import 'package:cryptotracker/providers/setting_service.dart';
import 'package:cryptotracker/providers/tracker_service.dart';
import 'package:cryptotracker/screens/add_currency.dart';
import 'package:cryptotracker/screens/loading_screen.dart';
import 'package:cryptotracker/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    textScaleFactor: 1.4,
                    style: GoogleFonts.architectsDaughter(
                        fontWeight: FontWeight.bold),
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
          Expanded(
            child: Consumer<Tracker>(builder: (_, value, __) {
              if (value.currentPrices.length > 0 && !value.loading)
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'BITCOIN',
                            style: GoogleFonts.rockSalt(),
                            textScaleFactor: 1.1,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final currency =
                              value.currentPrices.keys.toList()[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Color(0xff7DCFB6).withOpacity(0.8),
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              value.currentPrices[currency].bpi
                                                  .country.countryName,
                                              style: GoogleFonts.rockSalt(),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () => value.removeCountry(
                                              value.currentPrices[currency].bpi
                                                  .country),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${value.currentPrices[currency].bpi.rate} ${value.currentPrices[currency].bpi.country.currency}',
                                      style: GoogleFonts.delius(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'Last Updated',
                                            style: GoogleFonts.delius(),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${value.currentPrices[currency].time.toLocal().hour}:${value.currentPrices[currency].time.toLocal().minute}',
                                            style: GoogleFonts.delius(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: value.currentPrices.length,
                      ),
                    ),
                  ],
                );
              else if (value.currentPrices.length == 0 && !value.loading)
                return Container(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Press the + button at the top right corner to add a currency',
                        style: GoogleFonts.architectsDaughter(
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1.1,
                      ),
                    ),
                  ),
                );
              return LoadingScreen();
            }),
          ),
        ],
      ),
    );
  }
}
