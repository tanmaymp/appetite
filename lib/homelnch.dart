import 'package:flutter/material.dart';
import 'package:appetite/Menulunch.dart';

class homelnch extends StatefulWidget {
  @override
  _homelnchState createState() => _homelnchState();
}

class _homelnchState extends State<homelnch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Center(
              child: Text(
                "Lunch",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          // Menu(),
          MenuL(),
        ],
      ),
    );
  }
}
