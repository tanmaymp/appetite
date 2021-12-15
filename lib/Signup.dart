import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appetite/services/usermgmt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  State createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> fk = new GlobalKey<FormState>();

  String _emailID;
  String _password;
  String _dispname;
  String _mnumber;
  /* AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;*/

  /*@override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }*/

  /*bool validate() {
    print("Clicked");
    if (fk.currentState.validate()) {
      fk.currentState.save();
      print("Email - $_emailID password - $_password");
      runApp(new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ));
      return true;
    }
    return false;
  }*/

  void validatesubmit() async {
    final fstate = fk.currentState;
    if (fstate.validate()) {
      print(_emailID);
      fstate.save();
      print(_emailID);
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailID, password: _password);
        //user.sendEmailVerification()
        print("Created");
        Firestore.instance.collection("cards").document(user.uid).setData({
          "custId":"new",
          "email":user.email,
        });
        UserManagement().storeNewUser(user, _dispname, _mnumber, context);
        //UserManagement().addcart(user, context);
        Navigator.pop(context);
      } catch (e) {
        print('Error $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white70,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/food.jpg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            new Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              /*CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60.0,
                  child: Icon(
                    Icons.restaurant,
                    color: Colors.black,
                    size: _iconAnimation.value * 70.0,
                  ))
              new Padding(padding: EdgeInsets.all(10.0)),*/
              new Form(
                key: fk,
                child: Theme(
                  // ignore: undefined_getter
                  data: new ThemeData(
                      primarySwatch: Colors.grey,
                      brightness: Brightness.dark,
                      inputDecorationTheme: new InputDecorationTheme(
                          hintStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal))),
                  child: new Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 50.0, right: 50.0),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration:
                                new InputDecoration(hintText: "Enter UserID"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (String value) => !value.contains('@')
                                ? 'Not a valid email.'
                                : null,
                            onSaved: (String value) => _emailID = value,
                          ),
                          new Padding(padding: EdgeInsets.only(top: 10.0)),
                          new TextFormField(
                            obscureText: true,
                            decoration:
                                new InputDecoration(hintText: "Enter password"),
                            keyboardType: TextInputType.text,
                            validator: (String value) =>
                                value.length<6 ? "Minimum 6 characters required" : null,
                            onSaved: (String value) => _password = value,
                          ),
                          new Padding(padding: EdgeInsets.only(top: 10.0)),
                          new TextFormField(
                            //obscureText: true,
                            decoration:
                            new InputDecoration(hintText: "Enter name"),
                            keyboardType: TextInputType.text,
                            validator: (String value) =>
                            value.isEmpty ? "Enter your name" : null,
                            onSaved: (String value) => _dispname = value,
                          ),
                          new Padding(padding: EdgeInsets.only(top: 10.0)),
                          new TextFormField(
                            decoration:
                            new InputDecoration(hintText: "Enter mobile number"),
                            keyboardType: TextInputType.text,
                            validator: (String value) =>
                            value.length!=10 ? "Enter 10 digit number" : null,
                            onSaved: (String value) => _mnumber = value,
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: new RaisedButton(
                  color: Colors.white,
                  onPressed: validatesubmit,
                  child: new Text(
                    "Sign Up",
                    style: new TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}

/*validator: (val) =>
!val.contains('@') ? 'Not a valid email.' : null,*/
