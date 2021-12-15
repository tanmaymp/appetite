import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appetite/editMenu.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/services/addToCart.dart';
import 'package:appetite/Homepage.dart';
import 'package:appetite/globaluser.dart' as global;
import 'package:appetite/COhome.dart';

class CanOrders extends StatefulWidget {
  _CanOrdersState createState() => new _CanOrdersState();
}

class _CanOrdersState extends State<CanOrders> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          title: new Text(
            "Order History",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => COhomepage()));
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream:
                  Firestore.instance.collection("CanOrderHistory").snapshots(),
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
                        plateitem_date: snapshot.data.documents[index]
                            ['orderdate'],
                        plateitem_bal: snapshot.data.documents[index]
                            ['orderbal'],
                        plateitem_qty: snapshot.data.documents[index]
                            ['itemqty'],
                        plateitem_tot: snapshot.data.documents[index]
                            ['ordertotal'],
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

  MyOrderGen({
    this.plateitem_name,
    this.plateitem_bal,
    this.plateitem_tot,
    this.plateitem_qty,
    this.plateitem_date,
  });
  @override
  Widget build(BuildContext context) {
    crudMethods obj = crudMethods();
    return Card(
      child: ListTile(
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
