import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManagement {
  var usname;
  var userdoc;

  storeNewUser(user, dispname, number, context) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'dispname': dispname,
      'number': number,
      'photoURL':
          "https://firebasestorage.googleapis.com/v0/b/canteen-app-44e1a.appspot.com/o/profilepics%2Fdefault.png?alt=media&token=a5292de2-079f-45ec-9d48-9fad926ea7e2"
    }).catchError((e) {
      print(e);
    });
  }

  addcart(user, context) {
    /*Firestore.instance
        .collection('/cart${user.email}')
        .add({'uid': "9"}).then((val) {
      print(val);
    }).catchError((e) {
      print(e);
    });*/
    Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .getDocuments()
        .then((val) {
      print(val.documents[0].documentID);
      Firestore.instance
          .collection('users')
          .document(val.documents[0].documentID)
          .collection('cart')
          .add({"id": "0"});
    }).catchError((e) {
      print(e);
    });
  }
}
