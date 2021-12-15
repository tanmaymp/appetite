import 'package:flutter/material.dart';
import 'package:appetite/Menubr.dart';

class homeBreak extends StatefulWidget {
  @override
  _homeBreakState createState() => _homeBreakState();
}

class _homeBreakState extends State<homeBreak> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Center(
              child: Text(
                "Breakfast",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          // Menu(),
          MenuB(),
        ],
      ),
    );
  }
}
