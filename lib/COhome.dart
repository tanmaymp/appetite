import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'COordergen.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/editMenu.dart';
import 'package:appetite/COorderhis.dart';

class COhomepage extends StatefulWidget {
  @override
  _COhomepage createState() => new _COhomepage();
}

class _COhomepage extends State<COhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: new Text(
          "Canteen",
          style: new TextStyle(color: Colors.white),
        ),
      ),
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
                    "Tanmay",
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: new Text(
                    'rand@gmail',
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
                    splashColor: Colors.tealAccent,
                    child: new ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    COhomepage()));*/
                      },
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => editMenu()));
                  },
                  leading: new Icon(
                    Icons.mode_edit,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    "Edit Menu",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
                new ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CanOrders()));
                  },
                  leading: new Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  title: new Text(
                    "Order History",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
                new Divider(
                  color: Colors.white70,
                ),
                new ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((val) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    });
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
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "Orders",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
              ),
              Flexible(
                child: OrderList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
