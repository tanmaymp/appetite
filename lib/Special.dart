import 'package:flutter/material.dart';
import 'package:appetite/ItemDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Special extends StatefulWidget {
  @override
  _SpecialState createState() => _SpecialState();
}

class _SpecialState extends State<Special> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("Special").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            width: 0.0,
            height: 0.0,
          );
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                print("Specail len");
                print(snapshot.data.documents.length);
                if (snapshot.data.documents.length == 0) {
                  return Container(
                    width: 150,
                    child: Center(
                      child: Text("No Orders Yet"),
                    ),
                  );
                } else {
                  var status = snapshot.data.documents[index]["status"];
                  if (status == 1) {
                    return SingleR(
                      item_cat: snapshot.data.documents[index]['id'],
                      item_name: snapshot.data.documents[index]['name'],
                      item_pic: snapshot.data.documents[index]['picture'],
                      item_price: snapshot.data.documents[index]['price'],
                    );
                  } else {
                    return Container(
                      height: 0.0,
                      width: 0.0,
                    );
                  }
                }
              });
        }
      },
    );
  }
}

class SingleR extends StatelessWidget {
  @override
  final item_pic;
  final item_name;
  final item_cat;
  final item_price;
  final item_status;

  SingleR(
      {this.item_name,
      this.item_pic,
      this.item_cat,
      this.item_status,
      this.item_price});
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
                      leading: Text(
                        item_name,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      trailing: Text(
                        "Rs $item_price",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
