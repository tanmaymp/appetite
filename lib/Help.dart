import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:appetite/Cart.dart';
import 'package:appetite/ProfilePage.dart';

import 'package:appetite/loginscreen.dart';
import 'package:appetite/MyOrders.dart';

import 'package:appetite/Homepage.dart';
import 'package:appetite/globaluser.dart' as global;

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          actions: <Widget>[

            new IconButton(
                icon: Icon(Icons.restaurant, color: Colors.white),
                onPressed: () {
                  String docss;
                  FirebaseAuth.instance.currentUser().then((user) {
                    Firestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: user.uid)
                        .getDocuments()
                        .then((docs) {
                      docss = docs.documents[0].documentID.toString();
                      print("from itemdetials $docss");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Plate(docss: docss)));
                      //getdocs(str);
                    });
                  });
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.black87,
          title: new Text(
            "Help",
            style: new TextStyle(color: Colors.white),
          )),
      drawer: Container(
        width: 290.0,
        child: new Drawer(
          elevation: 10.0,
          child: Container(
            width: 10.0,
            color: Colors.black,
            child: ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text(
                    global.username,
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: new Text(
                    global.email,
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.white70,
                  ),
                  currentAccountPicture: new GestureDetector(
                    child: new CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      child: new Icon(
                        Icons.account_circle,
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: InkWell(
                    splashColor: Colors.white,
                    child: new ListTile(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage())),
                      leading: new Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      title: new Text(
                        "Home",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage())),
                  leading: new Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
                new ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyOrders())),
                  leading: new Icon(
                    Icons.fastfood,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    "My Orders",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
                new Divider(
                  color: Colors.white70,
                ),
                new ListTile(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Help())),
                  leading: new Icon(
                    Icons.help_outline,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    "Help",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
                new ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  leading: new Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                "We are right here",
                style: TextStyle(fontSize: 22.0),
              ),
              Divider(),
              Text(
                "For any issues, grieviences or compliments please drop a mail to the appetite team at custcare@appetite.com. We would love to hear from you !!.",
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
