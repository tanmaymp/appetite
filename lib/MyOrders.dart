import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:appetite/Cart.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/services/addToCart.dart';
import 'package:appetite/Homepage.dart';
import 'package:appetite/globaluser.dart' as global;

class MyOrders extends StatefulWidget {
  _myOrdersState createState() => new _myOrdersState();
}

class _myOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
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
              "My Orders",
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
                    onTap: () => Navigator.pop(context),
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("users")
                  .document(global.userdoc)
                  .collection("MyOrders")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return MyOrderGen(
                        plateitem_name: snapshot.data.documents[index]
                            ['itemname'],
                        plateitem_date: snapshot.data.documents[index]['date'],
                        plateitem_img: snapshot.data.documents[index]
                            ['itimage'],
                        plateitem_bal: snapshot.data.documents[index]
                            ['itbalance'],
                        plateitem_qty: snapshot.data.documents[index]
                            ['itemcount'],
                        plateitem_tot: snapshot.data.documents[index]
                            ['ittotal'],
                      );
                    },
                  );
                }
              }),
        ));
  }
}

class MyOrderGen extends StatelessWidget {
  final plateitem_name;
  final plateitem_bal;
  final plateitem_tot;
  final plateitem_qty;
  final plateitem_date;
  final plateitem_img;

  MyOrderGen({
    this.plateitem_name,
    this.plateitem_bal,
    this.plateitem_tot,
    this.plateitem_qty,
    this.plateitem_date,
    this.plateitem_img,
  });
  @override
  Widget build(BuildContext context) {
    crudMethods obj = crudMethods();
    return Card(
      child: ListTile(
        leading:
            /*Image(
              image: NetworkImage(plateitem_img),
              height: 100.0,
              width: 100.0,
            ),*/
            Container(
          height: 60.0,
          width: 70.0,
          decoration: BoxDecoration(
              //color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(plateitem_img))),
          /*child: Image.asset(
                    item_pic,
                    fit: BoxFit.cover,
                  ),*/
        ),
        title: Text(obj.getdate(plateitem_date)),
        subtitle: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(obj.gettime(plateitem_date)),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(plateitem_name),
                Text(",   Qty: $plateitem_qty"),
              ],
            ),
            Container(
              child: Text(
                "Rs $plateitem_tot",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ],
        ),
        trailing: plateitem_bal == 0
            ? Text(
                "PAID",
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Balance ",
                      style: TextStyle(color: Colors.red, fontSize: 15.0)),
                  Text("Rs $plateitem_bal",
                      style: TextStyle(color: Colors.red, fontSize: 22.0)),
                ],
              ),
      ),
    );
  }
}
