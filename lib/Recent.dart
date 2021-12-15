import 'package:flutter/material.dart';
import 'package:appetite/ItemDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:appetite/services/usermgmt.dart';
import 'package:appetite/globaluser.dart' as global;

class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  static var userdoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdoc().whenComplete((){
      print("Done future");
    });
  }

  @override
  var rec_list = [
    {
      "category": "rec11",
      "pic": "assets/hqdefault.jpg",
      "name": "PavBhaji",
      "price": "20",
    },
    {
      "category": "rec2",
      "pic": "assets/frice.jpg",
      "name": "Fried-Rice",
      "price": "20",
    },
    {
      "category": "rec3",
      "pic": "assets/vpav.jpg",
      "name": "Vada-Pav",
      "price": "20",
    },
    {
      "category": "rec4",
      "pic": "assets/vpav.jpg",
      "name": "Vada Pav",
      "price": "20",
    },
    {
      "category": "rec5",
      "pic": "assets/vpav.jpg",
      "name": "VadaPav",
      "price": "20",
    },
    {
      "category": "rec6",
      "pic": "assets/vpav.jpg",
      "name": "VadPav",
      "price": "20",
    },
    {
      "category": "rec7",
      "pic": "assets/cbhel.jpg",
      "name": "Chinese Bhel",
      "price": "20",
    }
  ];

  Future<String> getdoc() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print("userid");
    print(user.uid);
    /*CollectionReference ref = Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: user.uid)
        .reference();
    print(user.uid);
    QuerySnapshot doc = await ref.getDocuments();*/
    QuerySnapshot doc = await Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: user.uid)
        .getDocuments();
    String str = doc.documents[0].documentID.toString();
    userdoc = str;
    print(str);
    return str;
  }

  fetch() async {
    userdoc = await getdoc();
    //return userdoc;
  }
  Widget build(BuildContext context) {
    print("In recent");
    print(global.username);
    print(global.userdoc);
    setState(() {
      getdoc();
      fetch();
    });
    //var x = fetch();
    print("thisss $userdoc");
    //print(x);
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(global.userdoc)
          .collection("MyOrders")
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            width: 150,
            child: Center(
              child: Text("No Orders Yet"),
            ),
          );
        } else {
          print("HEREEEEEEEEEEEE");
          print(snapshot.data.documents.length);
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data.documents.length == 0) {
                  return Container(
                    width: 150,
                    child: Center(
                      child: Text("No Orders Yet"),
                    ),
                  );
                } else {
                  return SingleR(
                    item_cat: snapshot.data.documents[index]['itcat'],
                    item_name: snapshot.data.documents[index]['itemname'],
                    item_pic: snapshot.data.documents[index]['itimage'],
                    item_price: snapshot.data.documents[index]['itprice'],
                  );
                }
              });
        }
      },
    );
  }
}

class SingleR extends StatelessWidget {
  @override
  final item_cat;
  final item_pic;
  final item_name;
  final item_price;

  SingleR({this.item_name, this.item_pic, this.item_cat, this.item_price});
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
            splashColor: Colors.teal,
            child: Container(
              width: 150.0,
              child: GridTile(
                  footer: Container(
                    height: 50.0,
                    color: Colors.white70,
                    child: ListTile(
                      leading: Center(
                        child: Text(
                          item_name,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  child: Image(
                    image: NetworkImage(item_pic),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

/*
return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(doc)
          .collection("MyOrders")
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          print("HEREEEEEEEEEEEE");
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return SingleR(
                item_cat: snapshot.data.documents[index]['itcat'],
                item_name: snapshot.data.documents[index]['itemname'],
                item_pic: snapshot.data.documents[index]['itimage'],
                item_price: snapshot.data.documents[index]['itprice'],
              );
            },
          );
        }
      },
    );
 */
/*
main() async {
  print(await getData());
}
-L_hds1Gx7ZvrHclddxo
Future<Null> getDatare() async{return "a";}
 */
