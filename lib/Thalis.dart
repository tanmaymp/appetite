import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appetite/ItemDetails.dart';
import 'package:appetite/Menubr.dart';
import 'package:appetite/LunchOpts.dart';
import 'package:appetite/Cart.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/Homepage.dart';
import 'package:appetite/services/addToCart.dart';
import 'package:appetite/globaluser.dart' as global;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:appetite/Beverages.dart';

class thali extends StatefulWidget {
  @override
  _thaliState createState() => _thaliState();
}

class _thaliState extends State<thali> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Appetite",
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
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage())),
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
                    onTap: () {
                      FirebaseAuth.instance.currentUser().then((us) {
                        Firestore.instance
                            .collection("users")
                            .where("uid", isEqualTo: us.uid)
                            .getDocuments()
                            .then((d) {
                          String str = d.documents[0].documentID.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrders()));
                        });
                      });
                    },
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
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Help())),
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
                      Fluttertoast.showToast(
                        msg: "Signed Out",
                        backgroundColor: Colors.black45,
                        textColor: Colors.white70,
                        fontSize: 14.0,
                      );
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
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
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          height: 35.0,
                          width: 10000.0,
                          color: Colors.greenAccent,
                          child: Center(
                              child: Text(
                            "Veg",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ))),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Steam Rice"),
                              Text("Dal"),
                              Text("Chapatis(2)"),
                              Text("Papad"),
                              Text("Gobi sabzi"),
                              Text("Mixed vegetable"),
                            ],
                          ),
                          Center(
                            child: Text("Rs 40"),
                          ),
                          Center(
                            child: RaisedButton(
                              onPressed: () {
                                //print(item_pic);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new ItemDetails(
                                              itemdet_price: "40",
                                              itemdet_cat: "thaliveg",
                                              itemdet_img:
                                                  "https://firebasestorage.googleapis.com/v0/b/canteen-app-44e1a.appspot.com/o/Menu%2FVeg%20Thali.jpg?alt=media&token=9bbf0bf7-0a13-4c3d-a72b-3fa6808a2c91",
                                              itemdet_name: "Veg Thali",
                                            )));
                              },
                              child: Text("Order"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          height: 35.0,
                          width: 10000.0,
                          color: Colors.redAccent,
                          child: Center(
                              child: Text(
                            "Non Veg",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ))),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Steam Rice"),
                              Text("Dal"),
                              Text("Chapatis(2)"),
                              Text("Papad"),
                              Text("Chicken Kadai"),
                            ],
                          ),
                          Center(
                            child: Text("Rs 50"),
                          ),
                          Center(
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new ItemDetails(
                                              itemdet_price: "40",
                                              itemdet_cat: "thaliveg",
                                              itemdet_img:
                                                  "https://firebasestorage.googleapis.com/v0/b/canteen-app-44e1a.appspot.com/o/Menu%2Fnonveg%20thali.jpg?alt=media&token=60db2006-a1d8-48f5-8c4b-a07a7186b6d5",
                                              itemdet_name: "Non-veg Thali",
                                            )));
                              },
                              child: Text("Order"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
