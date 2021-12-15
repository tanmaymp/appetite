import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appetite/services/addToCart.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderList createState() => _OrderList();
}

class _OrderList extends State<OrderList> {
  List<bool> _data = new List<bool>();
  @override
  void _onChecked(bool value) {}
  var plate_list = [
    {
      "cat": "menu1",
      "name": "Pav Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/hqdefault.jpg",
    },
    {
      "cat": "menu2",
      "name": "Fried Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/frice.jpg",
    },
    {
      "cat": "menu1",
      "name": "Pav Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/hqdefault.jpg",
    },
    {
      "cat": "menu2",
      "name": "Fried Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/frice.jpg",
    },
    {
      "cat": "menu2",
      "name": "Fried Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/frice.jpg",
    },
    {
      "cat": "menu2",
      "name": "Fried Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/frice.jpg",
    },
    {
      "cat": "menu2",
      "name": "Fried Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/frice.jpg",
    },
    {
      "cat": "menu2",
      "name": "Fried Bhaji",
      "cost": "50",
      "qty": "2",
      "image": "assets/frice.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('CanteenOrders')
          .orderBy('date', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          print("Empty order");
          return Container(
              child: Center(
            child: Text("NO ORDERS YET"),
          ));
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return PlateSingledtful(
                  plateitem_tot: snapshot.data.documents[index]["ittotal"],
                  plateitem_cust: snapshot.data.documents[index]["itcust"],
                  plateitem_name: snapshot.data.documents[index]["itemname"],
                  plateitem_bal: snapshot.data.documents[index]["itbalance"],
                  plateitem_qty: snapshot.data.documents[index]["itemcount"],
                  plateitem_date: snapshot.data.documents[index]["date"],
                );
              });
        }
      },
    );
  }
}

class PlateSingledtful extends StatefulWidget {
  final plateitem_name;
  final plateitem_bal;
  final plateitem_cust;
  final plateitem_tot;
  final plateitem_qty;
  final plateitem_date;
  const PlateSingledtful(
      {Key key,
      @required this.plateitem_name,
      @required this.plateitem_bal,
      @required this.plateitem_date,
      @required this.plateitem_tot,
      @required this.plateitem_qty,
      @required this.plateitem_cust})
      : super(key: key);
  @override
  _PlateSingledtfulState createState() => _PlateSingledtfulState();
}

class _PlateSingledtfulState extends State<PlateSingledtful> {
  bool _val = false;
  @override
  remove() {
    print(widget.plateitem_name);
    Firestore.instance.collection("CanOrderHistory").add({
      "itemname": widget.plateitem_name,
      "itemqty":widget.plateitem_qty,
      "ordertotal" : widget.plateitem_tot,
      "orderdate" : widget.plateitem_date,
      "orderbal" : widget.plateitem_bal,
      "customer" : widget.plateitem_cust,
    });
    Firestore.instance
        .collection("CanteenOrders")
        .where("itemname", isEqualTo: widget.plateitem_name)
        .getDocuments()
        .then((d) {
      Firestore.instance
          .collection("CanteenOrders")
          .document(d.documents[0].documentID)
          .delete();
    });
  }

  Widget build(BuildContext context) {
    _val = false;
    var customer = widget.plateitem_cust;
    var qty = widget.plateitem_qty;
    var tot = widget.plateitem_tot;
    crudMethods obj = new crudMethods();
    print("here1");
    String time = obj.getdate(widget.plateitem_date);
    print("here2");
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          /*leading: Container(
            child: Text("1"),
            height: 100.0,
            width: 100.0,
          ),*/
          title: Text(
            widget.plateitem_name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Text("Custoemr: $plateitem_cust,"),
              Text(
                "Order by: $customer",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
              ),
              Text(
                "Ordered at : $time",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
              ),

              Text(
                "Qty : $qty",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          trailing:
              /*Container(
             width: 50.0,
              child: CheckboxListTile(value: false, onChanged: (bool val){print(val);})),*/
              Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  "$tot",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              Container(
                  width: 50.0,
                  child: Checkbox(
                      activeColor: Colors.black87,
                      value: _val,
                      onChanged: (bool _chval) {
                        remove();
                        setState(() {
                          _val = _chval;
                        });
                      })),
              //CheckboxListTile(value: false, onChanged: (bool val){print(val);})
              /*IconButton(
                  icon: Icon(Icons.check_box_outline_blank,
                      color: Colors.black87),
                  onPressed: () {})*/
              /*CheckboxListTile(
                  value: false, onChanged: (bool value){print(value);})*/
            ],
          ),
        ),
      ),
    );
  }
}
