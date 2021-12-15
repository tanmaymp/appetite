import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appetite/Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:appetite/HomePage.dart';
import 'package:appetite/services/addToCart.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'services/paymentServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:appetite/services/paymentServices.dart';
import 'dart:async';

class payOption extends StatefulWidget {
  final amount;
  @override
  const payOption({Key key, @required this.amount}) : super(key: key);

  @override
  _payOptionState createState() => _payOptionState();
}

class _payOptionState extends State<payOption> {
  @override
  Widget build(BuildContext context) {
    int amount = widget.amount;
    return Scaffold(
        appBar: AppBar(
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
                      "Tanmay",
                      style: TextStyle(color: Colors.black),
                    ),
                    accountEmail: new Text(
                      'testnew@gmail.com',
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
                        onTap: () => Navigator.of(context).pop(),
                        // onTap: () => Navigator.push(context,  MaterialPageRoute(builder: (context) => HomePage())),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text("Amount"),
                  Text(
                    "Rs $amount",
                    style: TextStyle(fontSize: 90.0),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Payment Options",
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                "Pay Cash Later",
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
            ),
            Center(
              child: RaisedButton(
                  color: Colors.black87,
                  child: Text("Pay",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  onPressed: () {
                    crudMethods ob = crudMethods();
                    ob.addToCanOrderswithbal();
                  }),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                "Pay Online Now",
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
            ),
            Center(
              child: RaisedButton(
                  color: Colors.black87,
                  child: Text("Pay",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((usr) {
                      Firestore.instance
                          .collection("cards")
                          .document(usr.uid)
                          .get()
                          .then((data) {
                        var custId = data.data["custId"].toString();
                        if (custId == "new") {
                          print("new customer");
                          Fluttertoast.showToast(
                            msg: "Add your card",
                            backgroundColor: Colors.black45,
                            textColor: Colors.white70,
                            fontSize: 14.0,
                          );
                          StripeSource.addSource().then((token) {
                            PaymentServices().addCard(token);
                          });
                        }else{
                          print("not new cust");
                          PaymentServices().buyItem(amount);
                          Fluttertoast.showToast(
                            msg: "PAID",
                            backgroundColor: Colors.black45,
                            textColor: Colors.white70,
                            fontSize: 14.0, );
                              crudMethods ob = crudMethods();
                          ob.addToCanOrders();

                        }
                      });
                    });
                    /*StripeSource.addSource().then((token) {
                      PaymentServices().addCard(token);
                    });
                    crudMethods ob = crudMethods();
                    ob.addToCanOrders();*/
                    //obj.addToMyOrders():
                  }),
            )
          ],
        ));
  }
}

/*
 RaisedButton(child: Text("Pay Cash Later "), onPressed: () {}),
            RaisedButton(child: Text("Pay Online Now"), onPressed: () {})
 */
