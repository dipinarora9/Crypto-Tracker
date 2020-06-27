import 'package:cryptotracker/screens/tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Tracker',
      home: TrackerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
