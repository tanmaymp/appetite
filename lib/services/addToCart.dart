import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class crudMethods {
  var username;
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> getuser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print("u $user");
    return user;
  }

  Future<String> getuserdispname() async {
    FirebaseUser user = await getuser();
    QuerySnapshot docs = await Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .getDocuments();
    var str = docs.documents[0]['dispname'];
    return str;
  }

  getdata() async {
    FirebaseAuth.instance.currentUser().then((usr) {
      Firestore.instance
          .collection('user')
          .where('uid', isEqualTo: usr.uid)
          .getDocuments()
          .then((doc) {
        return Firestore.instance
            .collection('user')
            .document(doc.documents[0].documentID)
            .collection('cart')
            .reference();
      });
    });
  }

  String gettime(Timestamp ts) {
    //var hour,min;
    var dt = ts.toDate();
    var hour = dt.hour;
    var min = dt.minute;
    if (hour > 12) {
      hour = hour - 12;
      if (hour % 10 == hour) {
        print("here1");
        if (min % 10 == min) {
          return "0$hour:0$min pm";
        } else {
          return "0$hour:$min pm";
        }
      } else {
        if (min % 10 == min) {
          return "$hour:0$min pm";
        } else {
          return "$hour:$min pm";
        }
      }
    } else {
      if (hour % 10 == hour) {
        if (min % 10 == min) {
          return "0$hour:0$min pm";
        } else {
          return "0$hour:$min pm";
        }
      } else {
        if (min % 10 == min) {
          return "$hour:0$min pm";
        } else {
          return "$hour:$min pm";
        }
      }
    }
  }

  signedouttoast() {
    Fluttertoast.showToast(
      msg: "Signed Out",
      backgroundColor: Colors.black45,
      textColor: Colors.white70,
      fontSize: 14.0,
    );
  }

  getdate(Timestamp ts) {
    var dt = ts.toDate();
    var dd = dt.day;
    var mm = dt.month;
    var yy = dt.year;
    return "$dd/$mm/$yy";
  }

  addData(name, price, img, cat, count) async {
    if (isLoggedIn()) {
      int tot = int.parse(price) * int.parse(count);
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .collection('users')
              .document(docs.documents[0].documentID)
              .collection('cart')
              .add({
            'ituid': cat,
            'itname': name,
            'itprice': price,
            'itimg': img,
            'itcount': count,
            'ittotal': tot,
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  addToCanOrders() {
    if (isLoggedIn()) {
      print("In add function");
      FirebaseAuth.instance.currentUser().then((user) {
        print(user.email);
        Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((ddocs) {
          var name = ddocs.documents[0]['dispname'];
          addDatatoOrders(ddocs, name);
        });
      });
    }
  }

  addToCanOrderswithbal() {
    if (isLoggedIn()) {
      print("In add function");
      FirebaseAuth.instance.currentUser().then((user) {
        print(user.email);
        Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((ddocs) {
          var name = ddocs.documents[0]['dispname'];
          addDatatoOrderswithbal(ddocs, name);
        });
      });
    }
  }
  addDatatoOrderswithbal(QuerySnapshot docs, usern) {
    if (isLoggedIn()) {
      print("Adding to main orders order from $usern");
      Firestore.instance
          .collection('users')
          .document(docs.documents[0].documentID)
          .collection('cart')
          .getDocuments()
          .then((dox) {
        int l = dox.documents.length;
        int i = 0;
        while (i < l) {
          Firestore.instance.collection('CanteenOrders').add({
            'itemname': dox.documents[i]['itname'],
            'itemcount': dox.documents[i]['itcount'],
            'itprice': dox.documents[i]['itprice'],
            'ittotal': dox.documents[i]['ittotal'],
            'itbalance': dox.documents[i]['ittotal'],
            'itcust': usern,
            'date': Timestamp.now(),
          });
          i = i + 1;
        }
      });
      print("Adding to MyOrders order from $usern");
      Firestore.instance
          .collection('users')
          .document(docs.documents[0].documentID)
          .collection('cart')
          .getDocuments()
          .then((dox) {
        int l = dox.documents.length;
        int i = 0;
        while (i < l) {
          Firestore.instance
              .collection('users')
              .document(docs.documents[0].documentID)
              .collection('MyOrders')
              .add({
            'itcat': dox.documents[i]['ituid'],
            'itemname': dox.documents[i]['itname'],
            'itemcount': dox.documents[i]['itcount'],
            'itprice': dox.documents[i]['itprice'],
            'ittotal': dox.documents[i]['ittotal'],
            'itimage': dox.documents[i]['itimg'],
            'itbalance': dox.documents[i]['ittotal'],
            'date': Timestamp.now(),
          });
          i = i + 1;
        }
      });
    }
  }

  addDatatoOrders(QuerySnapshot docs, usern) {
    if (isLoggedIn()) {
      print("Adding to main orders order from $usern");
      Firestore.instance
          .collection('users')
          .document(docs.documents[0].documentID)
          .collection('cart')
          .getDocuments()
          .then((dox) {
        int l = dox.documents.length;
        int i = 0;
        while (i < l) {
          Firestore.instance.collection('CanteenOrders').add({
            'itemname': dox.documents[i]['itname'],
            'itemcount': dox.documents[i]['itcount'],
            'itprice': dox.documents[i]['itprice'],
            'ittotal': dox.documents[i]['ittotal'],
            'itbalance': 0,
            'itcust': usern,
            'date': Timestamp.now(),
          });
          i = i + 1;
        }
      });
      print("Adding to MyOrders order from $usern");
      Firestore.instance
          .collection('users')
          .document(docs.documents[0].documentID)
          .collection('cart')
          .getDocuments()
          .then((dox) {
        int l = dox.documents.length;
        int i = 0;
        while (i < l) {
          Firestore.instance
              .collection('users')
              .document(docs.documents[0].documentID)
              .collection('MyOrders')
              .add({
            'itcat': dox.documents[i]['ituid'],
            'itemname': dox.documents[i]['itname'],
            'itemcount': dox.documents[i]['itcount'],
            'itprice': dox.documents[i]['itprice'],
            'ittotal': dox.documents[i]['ittotal'],
            'itimage': dox.documents[i]['itimg'],
            'itbalance': 0,
            'date': Timestamp.now(),
          });
          i = i + 1;
        }
      });
    }
  }

  addToMyOrders(name, price, img, cat, count) {
    if (isLoggedIn()) {
      int tot = int.parse(price) * int.parse(count);
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .collection('users')
              .document(docs.documents[0].documentID)
              .collection('MyOrders')
              .add({
            'ituid': cat,
            'itname': name,
            'itprice': price,
            'itimg': img,
            'itcount': count,
            'ittotal': tot,
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}
