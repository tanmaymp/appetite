import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlateItems extends StatefulWidget {
  final String docss;

  const PlateItems({Key key, @required this.docss}) : super(key: key);
  @override
  _PlateItemsState createState() => _PlateItemsState();
}

class _PlateItemsState extends State<PlateItems> {
  Stream<QuerySnapshot> results;
  String docss;

  int GT;

  @override
  Widget build(BuildContext context) {
    String dd = widget.docss;
    print("in bbuild $dd");

    return StreamBuilder(
        stream: Firestore.instance
            .collection("users")
            .document(widget.docss)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return ListView.builder(
                padding: EdgeInsets.only(top: 2.0),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return PlateSingle(
                    plateitem_cat: snapshot.data.documents[index]['ituid'],
                    plateitem_img: snapshot.data.documents[index]['itimg'],
                    plateitem_name: snapshot.data.documents[index]['itname'],
                    plateitem_price: snapshot.data.documents[index]['itprice'],
                    plateitem_qty: snapshot.data.documents[index]['itcount'],
                    ddocs: widget.docss,
                    total: GT,
                  );
                });
          }
        });
  }
}

class PlateSingle extends StatelessWidget {final plateitem_name;
  final plateitem_img;
  final plateitem_price;
  final plateitem_qty;
  final ddocs;
  var total;

  var plateitem_cat;

  PlateSingle({
    this.plateitem_cat,
    this.plateitem_img,
    this.plateitem_name,
    this.plateitem_price,
    this.plateitem_qty,
    this.ddocs,
    this.total,
  });
  String tot() {
    int t = int.parse(plateitem_qty) * int.parse(plateitem_price);
    print("In total");
    return "Rs $t";
  }

  remove() {
    print(plateitem_name);
    Firestore.instance
        .collection("users")
        .document(ddocs)
        .collection('cart')
        .where('itname', isEqualTo: plateitem_name)
        .getDocuments()
        .then((doc) {
      Firestore.instance
          .collection("users")
          .document(ddocs)
          .collection('cart')
          .document(doc.documents[0].documentID)
          .delete();
    }).catchError((e) {
      print(e);
    });
  }

  //@override
  Widget build(BuildContext context) {
    //total = total + tot();
    return Container(
      child: Card(
        elevation: 5.0,
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
          title: Text("$plateitem_name"),
          subtitle: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Price: $plateitem_price,"),
                  Text("Qty: $plateitem_qty"),
                ],
              ),
              Container(
                child: Text(
                  tot(),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.black87,
              ),
              onPressed: () {
                remove();
                print("Pressed");
                Fluttertoast.showToast(
                  msg: "Item removed",
                  backgroundColor: Colors.black45,
                  textColor: Colors.white70,
                  fontSize: 18.0,
                );
              }),
        ),
      ),
    );
  }
}
