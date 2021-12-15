import 'package:flutter/material.dart';
import 'package:appetite/ItemDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:appetite/Cart.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/loginscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuN extends StatefulWidget {
  @override
  _MenuNState createState() => _MenuNState();
}

class _MenuNState extends State<MenuN> {
  @override
  Widget build(BuildContext context) {
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
                    "rr",
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: new Text(
                    'tanmay',
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
                    Fluttertoast.showToast(
                      msg: "Signed Out",
                      backgroundColor: Colors.black45,
                      textColor: Colors.white70,
                      fontSize: 14.0,
                    );
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
      body: StreamBuilder(
        stream: Firestore.instance.collection("chicMenuLu").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  var status = snapshot.data.documents[index]["status"];
                  if (status == "0") {
                    return Container(
                      width: 0.0,
                      height: 0.0,
                    );
                  } else {
                    return Single(
                      item_name: snapshot.data.documents[index]["name"],
                      item_pic: snapshot.data.documents[index]["picture"],
                      item_price: snapshot.data.documents[index]["price"],
                      item_cat: snapshot.data.documents[index]["id"],
                    );
                  }
                });
          }
        },
      ),
    );
  }
}

class Single extends StatelessWidget {
  @override
  final item_pic;
  final item_name;
  final item_price;
  final item_cat;

  Single({this.item_name, this.item_price, this.item_pic, this.item_cat});
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Hero(
        tag: item_cat,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new ItemDetails(
                          itemdet_price: item_price,
                          itemdet_cat: item_cat,
                          itemdet_img: item_pic,
                          itemdet_name: item_name,
                        ))),
            //onTap: ()=>print("clicked"),
            splashColor: Colors.teal,
            child: GridTile(
                footer: Container(
                  color: Colors.black45,
                  child: ListTile(
                    leading: Container(
                      width: 300,
                      child: Text(
                        item_name,
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                    trailing: Text(
                      "Rs $item_price",
                      style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(

                      //color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(item_pic))),
                  /*child: Image.asset(
                    item_pic,
                    fit: BoxFit.cover,
                  ),*/
                )),
          ),
        ),
      ),
    );
  }
}

/*
int _selectedPage = 0;
  final _pageOptions = [
    Special(),
    Recent(),
    MenuL(),
    Text('Item 3'),
  ];














body: _pageOptions[_selectedPage],
     bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(

              canvasColor: const Color(0xFF000000),
            ),
      child: new BottomNavigationBar(

        currentIndex: _selectedPage,
      onTap: (int index) {
    setState(() {
        _selectedPage = index;
    }

    );
},
 //Color backgroundColor: Colors.black87,//fixedColor: Colors.black87,
    items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('SPECIALS'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('RECENT ORDERS'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('VEG'),
        ),
         BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('NON-VEG'),
        ),
    ],

),
    ),
 */
