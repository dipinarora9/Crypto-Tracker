import 'package:cryptotracker/providers/setting_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        settings.saveUpdateInterval();
        return Future(() => false);
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    settings.saveUpdateInterval();
                    Navigator.of(context).pop(true);
                  },
                  icon: Icon(Icons.chevron_left),
                ),
                Text(
                  'Settings',
                  textScaleFactor: 1.4,
                  style: GoogleFonts.architectsDaughter(
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Update time interval (in minutes)',
                        textScaleFactor: 1.2,
                        style: GoogleFonts.architectsDaughter(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            '1',
                            style: GoogleFonts.architectsDaughter(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            '10',
                            style: GoogleFonts.architectsDaughter(),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 30),
                      child: Consumer<Settings>(
                        builder: (_, value, __) {
                          return Slider(
                            value: value.updateInterval.toDouble(),
                            onChanged: (v) =>
                                value.setUpdateInterval(v.toInt()),
                            min: 1,
                            max: 10,
                            divisions: 10,
                            label: value.updateInterval.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: InkWell(
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: 'Crypto Tracker',
                    applicationVersion: 'v1.0.0',
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'About',
                            style: GoogleFonts.architectsDaughter(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Powered by CoinDesk',
                          style: GoogleFonts.architectsDaughter(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          'https://www.coindesk.com/price/bitcoin',
                          style: GoogleFonts.architectsDaughter(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
