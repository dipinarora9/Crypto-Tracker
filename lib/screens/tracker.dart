import 'package:cryptotracker/providers/add_currency_service.dart';
import 'package:cryptotracker/providers/setting_service.dart';
import 'package:cryptotracker/screens/add_currency.dart';
import 'package:cryptotracker/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        child: SettingsScreen(),
                        create: (_) => Settings(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        child: AddCurrencyScreen(),
                        create: (_) => AddCurrency(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
