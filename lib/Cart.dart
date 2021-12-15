import 'package:flutter/material.dart';
import 'package:appetite/Plate_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:appetite/services/addToCart.dart';
import 'package:appetite/payOption.dart';
import 'package:appetite/globaluser.dart' as global;

class Plate extends StatefulWidget {
  final String docss;

  const Plate({Key key, @required this.docss}) : super(key: key);
  @override
  _PlateState createState() => _PlateState();
}

class _PlateState extends State<Plate> {
  static var str;
  QuerySnapshot results;
  crudMethods obj = new crudMethods();
  CollectionReference ref;

  gettotal() async {
    /*FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot docs = await Firestore.instance.collection("users").where("uid", isEqualTo: user.uid).getDocuments();
    print(docs.documents[0].documentID);*/
    QuerySnapshot ddocs = await Firestore.instance
        .collection("users")
        .document(global.userdoc)
        .collection("cart")
        .getDocuments();
    if (ddocs.documents.length == 0) {
      print("In zero cond");
      str = 0;
    } else {
      print("Count");
      print(ddocs.documents.length);
      int i = ddocs.documents.length;
      int sum = 0;
      while (i > 0) {
        sum = sum + ddocs.documents[i - 1]["ittotal"];
        i = i - 1;
      }
      str = sum;
    }
    print("in funct $str");
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      gettotal();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gettotal();
    print("sum $str");
    String d = widget.docss;
    print("from plate $d");
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: new Text(
          "Appetite",
          style: new TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "Your Plate",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
              ),
              Flexible(
                child: PlateItems(docss: widget.docss),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection("users")
                .document(global.userdoc)
                .collection("cart")
                .snapshots(),
            builder: (context, snaps) {
              int total = 0;
              int i = snaps.data.documents.length;
              print("Length $i");
              while (i > 0) {
                total = total + snaps.data.documents[i - 1]["ittotal"];
                i = i - 1;
              }
              return ListTile(
                title: Text("Total"),
                subtitle: Text("Rs $total"),
              );
            },
          ),
          /*child: stTile
            title: Text("Total"),
            subtitle: Text(str.toSt(Liring()),
          ),*/
        ),
        Expanded(
          child: MaterialButton(
              onPressed: () {
                Firestore.instance
                    .collection('users')
                    .document(global.userdoc)
                    .collection('cart')
                    .getDocuments()
                    .then((docs) {
                  int i = docs.documents.length;
                  int total = 0;
                  while (i > 0) {
                    total = total + docs.documents[i - 1]["ittotal"];
                    i--;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => payOption(amount: total)));
                });
              },
              color: Colors.black87,
              child: Text("Pay", style: TextStyle(color: Colors.white))),
        ),
      ]),
    );
  }
}
