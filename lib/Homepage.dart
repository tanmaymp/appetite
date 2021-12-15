import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:appetite/Menubr.dart';
import 'package:appetite/LunchOpts.dart';
import 'package:appetite/Cart.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/homepg.dart';
import 'package:appetite/services/addToCart.dart';
import 'package:appetite/globaluser.dart' as global;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:appetite/Beverages.dart';

class Homepage extends StatefulWidget {
  @override
  _homePageState createState() => new _homePageState();
}

class _homePageState extends State<Homepage> {
  FirebaseMessaging _msg = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _msg.getToken().then((token) {
      Firestore.instance
          .collection("users")
          .document(global.userdoc)
          .collection("Token")
          .getDocuments()
          .then((docs) {
        Firestore.instance
            .collection("users")
            .document(global.userdoc)
            .collection("Token")
            .document(docs.documents[0].documentID)
            .delete();
      });
      Firestore.instance
          .collection("users")
          .document(global.userdoc)
          .collection("Token")
          .add({"token": token});
    });
    StripeSource.setPublishableKey(
        'pk_test_ePNsk25ldJPsHfzKtsVm7iYu00y7mRgWtO');
  }

  int _selectedPage = 0;
  static var username;

  var _pageOptions = [
    homePg(),
    MenuB(),
    lunchOptions(), //MenuL(),
    Beverages(),
  ];

  getusername() async {
    print("hereeeeeeeeeeeeeeeeeeeeeeee");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot docs = await Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: user.uid)
        .getDocuments();
    username = docs.documents[0]["dispname"];
    print("in funct $username");
  }

  @override
  Widget build(BuildContext context) {
    var username = global.username;
    // TODO: implement build
    return new Scaffold(
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
                      username,
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
                        onTap: () => Navigator.of(context).pop(),
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
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black87,
          ),
          child: Container(
            height: 58.0,
            child: BottomNavigationBar(
                currentIndex: _selectedPage,
                onTap: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'HOME',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.free_breakfast,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'BREAKFAST',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'LUNCH',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_bar,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'BEVERAGES',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
