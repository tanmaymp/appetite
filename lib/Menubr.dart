import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:appetite/ItemDetails.dart';
import 'package:appetite/Cart.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/globaluser.dart' as global;

class MenuB extends StatefulWidget {
  @override
  _MenuBState createState() => _MenuBState();
}

class _MenuBState extends State<MenuB> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection("MenuBr").snapshots(),
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
                      item_price: snapshot.data.documents[index]["price"],
                      item_cat: snapshot.data.documents[index]["id"],
                      item_pic: snapshot.data.documents[index]["picture"],
                      /*item_name: item_list[index]['name'],
                item_pic: item_list[index]['pic'],
                item_price: item_list[index]['price'],
                item_cat: item_list[index]['category'],*/
                    );
                  }
                  ;
                });
          }
        });
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
            onTap: () {
              //print(item_pic);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ItemDetails(
                            itemdet_price: item_price,
                            itemdet_cat: item_cat,
                            itemdet_img: item_pic,
                            itemdet_name: item_name,
                          )));
            },
            //onTap: ()=>print("clicked"),
            splashColor: Colors.teal,
            child: GridTile(
                footer: Container(
                  height: 40.0,
                  color: Colors.black45,
                  child: ListTile(
                    leading: Text(
                      item_name,
                      style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
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
