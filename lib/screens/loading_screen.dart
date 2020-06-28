import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  final List<Color> _colors = [
    Color(0xffefefef),
    Color(0xfff7931a),
    Color(0xfff7931a),
    Color(0xffefefef),
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform.rotate(
                  angle: _controller.value * pi / 2,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    color: _colors[(_controller.value * pi % 4).toInt()],
                    child: SizedBox(
                      height: 60,
                      width: 60,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 20),
            child: Text(
              'Loading... Please wait',
              style: GoogleFonts.architectsDaughter(),
              textScaleFactor: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
