import 'package:flutter/material.dart';
import 'package:appetite/services/addToCart.dart';
import 'package:appetite/Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemDetails extends StatefulWidget {
  final itemdet_cat;
  final itemdet_name;
  final itemdet_img;
  final itemdet_price;

  ItemDetails(
      {this.itemdet_cat,
      this.itemdet_img,
      this.itemdet_name,
      this.itemdet_price});
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int _itemCount = 1;
  int _itemPrice = 1;
  //int _sum;

  //_ItemDetailsState({Key key}) : super(key: key);
  void addToCart() {
    //to database
    crudMethods crudobj = new crudMethods();
    crudobj.addData(widget.itemdet_name, widget.itemdet_price,
        widget.itemdet_img, widget.itemdet_cat, _itemCount.toString());
    new Tooltip(message: "Added to cart");
  }

  @override
  Widget build(BuildContext context) {
    _itemPrice = int.parse(widget.itemdet_price) * _itemCount;

    //print(itemdet_img);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.1,
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
        backgroundColor: Colors.black87.withOpacity(0.7),
        title: new Text(
          "Appetite",
          style: new TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipPath(
              child: Container(color: Colors.black87.withOpacity(0.7)),
              clipper: getClipper()),
          Container(
            color: Colors.black26,
            height: 450.0,
            width: 325.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Card(
                    elevation: 20.0,
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: widget.itemdet_cat,
                          child: GridTile(
                              child: Container(
                                  color: Colors.white,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      width: 300.0,
                                      height: 250.0,
                                      image: NetworkImage(widget.itemdet_img))
                                  /*Image.asset(
                              widget.itemdet_img,
                              width: 300.0,
                              height: 250.0,
                            ),*/
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.itemdet_name,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _itemCount != 0
                                ? IconButton(
                                    icon: Icon(Icons.remove_circle_outline),
                                    iconSize: 30.0,
                                    highlightColor: Colors.tealAccent,
                                    tooltip: "Less Hungry",
                                    onPressed: () => setState(() {
                                          _itemCount--;
                                          _itemPrice =
                                              int.parse(widget.itemdet_price) *
                                                  _itemCount;
                                        }))
                                : new Container(),
                            Text(
                              "$_itemCount",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                iconSize: 30.0,
                                tooltip: "More Hungry",
                                highlightColor: Colors.tealAccent,
                                onPressed: () => setState(() {
                                      _itemCount++;
                                      _itemPrice =
                                          int.parse(widget.itemdet_price) *
                                              _itemCount;
                                    }))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Rs $_itemPrice",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: InkWell(
                            splashColor: Colors.black45,
                            child: RaisedButton(
                              highlightColor: Colors.tealAccent,
                              splashColor: Colors.black12,
                              highlightElevation: 5.0,
                              color: Colors.black87,
                              onPressed: () {
                                Fluttertoast.showToast(
                                  msg: "Item added to plate",
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white70,
                                  fontSize: 14.0,
                                );
                                addToCart();
                              },
                              child: new Text(
                                "Add to plate",
                                style: new TextStyle(
                                    color: Colors.white70, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
