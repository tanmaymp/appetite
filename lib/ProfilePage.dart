import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appetite/globaluser.dart' as global;

import 'package:appetite/Cart.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/editprofile.dart';
import 'package:appetite/loginscreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /*static var dispname;
  static var number;
  static var email;
*/
  var username = global.username;
  var email = global.email;
  var number = global.number;
  var photoURL = global.photoURL;
  @override
  Widget build(BuildContext context) {
    //getdata();
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
        body: Container(
          color: Colors.white,
          child: Stack(fit: StackFit.expand, children: <Widget>[
            ClipPath(
                child: Container(
                  color: Colors.black87.withOpacity(0.8),
                ),
                clipper: getClipper()),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7.0,
                            color: Colors.black87,
                          )
                        ],
                        image: DecorationImage(
                            image: NetworkImage(photoURL),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0))),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("username:"),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                      global.username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.black87),
                    ),
                  ]),
                  Text("number:"),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                      global.number,
                      style: TextStyle(fontSize: 25.0, color: Colors.black54),
                    ),
                  ]),
                  Text("email:"),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                      global.email,
                      style: TextStyle(fontSize: 25.0, color: Colors.black54),
                    ),
                  ]),
                ]),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Edit Profile",
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white70,
          elevation: 5.0,
          child: Icon(Icons.mode_edit),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => editProfilePage())),
        ));
  }
}

_showDialogBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(children: <Widget>[
            Form(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    initialValue: global.username,
                    keyboardType: TextInputType.text,
                    validator: (String value) =>
                        value.isEmpty ? "Enter username" : null,
                    onSaved: (String value) => global.username = value,
                  ),
                  TextFormField(
                    initialValue: global.number,
                    keyboardType: TextInputType.number,
                    validator: (String value) =>
                        value.length != 10 ? "Enter valid number" : null,
                    onSaved: (String value) => global.number = value,
                  ),
                  TextFormField(
                    initialValue: global.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) =>
                        !value.contains("@") ? "Enter valid email" : null,
                    onSaved: (String value) => global.email = value,
                  )
                ],
              ),
            )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(child: Text("Save")),
                RaisedButton(
                  child: Text("Cancel"),
                )
              ],
            )
          ]),
        );
      });
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width + size.height / 2, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
