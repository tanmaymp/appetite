import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentServices {
  addCard(token) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('cards')
          .document(user.uid)
          .collection('tokens')
          .add({'tokenId': token}).then((val) {
        print('saved');
      });
    });
  }

  buyItem(price){

    var proprice = price*100;
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("cards").document(user.uid).collection("charges").add({
        "currency":"inr",
        "amount":proprice,
        "description":"Purchase of product"
      });
    });
  }
}