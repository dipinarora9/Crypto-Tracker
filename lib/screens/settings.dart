import 'package:cryptotracker/providers/setting_service.dart';
import 'package:flutter/material.dart';
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
            IconButton(
              onPressed: () {
                settings.saveUpdateInterval();
                Navigator.of(context).pop(true);
              },
              icon: Icon(Icons.arrow_left),
            ),
            Text(
              'Update time interval',
              textScaleFactor: 1.2,
            ),
            Consumer<Settings>(
              builder: (_, value, __) {
                return Slider(
                  value: value.updateInterval.toDouble(),
                  onChanged: (v) => value.setUpdateInterval(v.toInt()),
                  min: 1,
                  max: 20,
                  divisions: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
