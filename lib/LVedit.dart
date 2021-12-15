import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LVedit extends StatefulWidget {
  @override
  _LVeditState createState() => _LVeditState();
}

class _LVeditState extends State<LVedit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection("vegMenuLu").snapshots(),
        builder: (context, snaps) {
          if (snaps.data == null) {
            return Container(
              height: 0.0,
              width: 0.0,
            );
          } else {
            return ListView.builder(
              itemCount: snaps.data.documents.length,
              itemBuilder: (context, index) {
                return SingleTile(
                  SingleTile_name: snaps.data.documents[index]["name"],
                  SingleTile_price: snaps.data.documents[index]["price"],
                  SingleTile_status: snaps.data.documents[index]["status"],
                  SingeTile_id: snaps.data.documents[index]["id"],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class SingleTile extends StatefulWidget {
  final SingleTile_name;
  final SingleTile_price;
  final SingleTile_status;
  final SingeTile_id;

  const SingleTile(
      {Key key,
      @required this.SingleTile_name,
      @required this.SingleTile_price,
      @required this.SingleTile_status,
      @required this.SingeTile_id})
      : super(key: key);
  @override
  _SingleTileState createState() => _SingleTileState();
}

class _SingleTileState extends State<SingleTile> {
  @override
  Widget build(BuildContext context) {
    var id = widget.SingeTile_id;
    var name = widget.SingleTile_name;
    var price = widget.SingleTile_price;
    var status = widget.SingleTile_status;
    //print("Status now $status");
    return Container(
      height: 60.0,
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(5.0),
        child: Hero(
          tag: widget.SingeTile_id,
          transitionOnUserGestures: true,
          child: InkWell(
              onTap: () {
                _showDialoguebox(context, name, price, status, id);
              },
              highlightColor: Colors.white10,
              child: Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                    Text(name),
                    Text("Rs $price"),
                    //Text("status = $status"),
                    status == "1"
                        ? Text("Available",
                            style: TextStyle(color: Colors.green))
                        : Text("Unavailable",
                            style: TextStyle(color: Colors.red))
                  ]))),
        ),
      ),
    );
  }
}

_showDialoguebox(context, name, price, status, id) {
  final GlobalKey<FormState> fk = new GlobalKey<FormState>();
  var stst;
  if (status == "1") {
    stst = "Mark as unavailable";
  } else {
    stst = "Mark as available";
  }

  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5.0,
          title: Text("Edit"),
          contentPadding: EdgeInsets.all(8.0),
          backgroundColor: Colors.white,
          content: Form(
            key: fk,
            child: new Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new TextFormField(
                        initialValue: name,
                        keyboardType: TextInputType.text,
                        validator: (String value) =>
                            value.isEmpty ? 'Enter valid name' : null,
                        onSaved: (String value) => name = value,
                      ),
                      //new Padding(padding: EdgeInsets.only(top: 10.0)),
                      new TextFormField(
                        initialValue: price,
                        keyboardType: TextInputType.text,
                        validator: (String value) =>
                            value.isEmpty ? "ENter valid price" : null,
                        onSaved: (String value) => price = value,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      RaisedButton(
                        color: Colors.black87,
                        child: Text(
                          stst,
                          style: TextStyle(color: Colors.white70),
                        ),
                        onPressed: () {
                          if (status == "0") {
                            status = "1";
                          } else {
                            status = "0";
                          }
                          Fluttertoast.showToast(
                            msg: "DONE",
                            backgroundColor: Colors.black45,
                            textColor: Colors.white70,
                            fontSize: 14.0,
                          );

                          Firestore.instance
                              .collection("vegMenuLu")
                              .where("id", isEqualTo: id)
                              .getDocuments()
                              .then((doc) {
                            Firestore.instance
                                .collection("vegMenuLu")
                                .document(doc.documents[0].documentID)
                                .updateData({
                              "status": status,
                            });
                          });
                        },
                      )
                    ]),
              ),
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: Colors.black87,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () {
                final fstate = fk.currentState;
                if (fstate.validate()) {
                  Fluttertoast.showToast(
                    msg: "Changes Done",
                    backgroundColor: Colors.black45,
                    textColor: Colors.white70,
                    fontSize: 14.0,
                  );
                  fstate.save();
                  print(name);
                  print(price);
                  Firestore.instance
                      .collection("vegMenuLu")
                      .where("id", isEqualTo: id)
                      .getDocuments()
                      .then((doc) {
                    Firestore.instance
                        .collection("vegMenuLu")
                        .document(doc.documents[0].documentID)
                        .updateData({
                      "name": name,
                      "price": price,
                    });
                  });
                }
              },
            )
          ],
        );
      });
}
