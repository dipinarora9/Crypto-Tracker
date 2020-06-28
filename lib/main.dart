import 'package:cryptotracker/providers/tracker_service.dart';
import 'package:cryptotracker/screens/tracker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Tracker',
      home: ChangeNotifierProvider<Tracker>(
        create: (_) => Tracker()..initialize(),
        child: TrackerScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
