import 'package:flutter/material.dart';
import 'package:appetite/Carousal.dart';
import 'package:appetite/Special.dart';
import 'package:appetite/Recent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homePg extends StatefulWidget {
  final docss;
  @override
  const homePg({Key key, @required this.docss}) : super(key: key);

  @override
  _homePgState createState() => _homePgState();
}

class _homePgState extends State<homePg> {
  String userdoc;

  @override
  Widget build(BuildContext context) {
    //print("from homepg $userdoc");
    return Container(
      child: ListView(
        children: <Widget>[
          Carousal(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Today's special",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Container(
            height: 150.0,
            color: Colors.white,
            child: Special(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Recent orders",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Container(
            height: 150.0,
            color: Colors.white,
            child: Recent(),
          ),
        ],
      ),
    );
  }
}
