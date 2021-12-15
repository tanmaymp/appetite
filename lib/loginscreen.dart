import 'package:flutter/material.dart';
import 'package:appetite/Homepage.dart';
import 'package:appetite/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'COhome.dart';
import 'package:appetite/services/usermgmt.dart';
import 'package:appetite/globaluser.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> fk = new GlobalKey<FormState>();
  UserManagement obj = new UserManagement();
  String _emailID;
  String _password;
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

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

  Future<void> validatesubmit() async {
    Fluttertoast.showToast(
      msg: "Logging In ...",
      backgroundColor: Colors.black45,
      textColor: Colors.white70,
      fontSize: 14.0,
    );
    final fstate = fk.currentState;
    if (fstate.validate()) {
      print(_emailID);
      fstate.save();
      print(_emailID);
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _emailID, password: _password);

        if (user.email == "owner@gmail.com") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => COhomepage()));
        } else {

        QuerySnapshot docs = await Firestore.instance
            .collection("users")
            .where("uid", isEqualTo: user.uid)
            .getDocuments();
        print(user.uid);
        global.userdoc = docs.documents[0].documentID.toString();
        global.username = docs.documents[0]["dispname"];
        global.number = docs.documents[0]["number"];
        global.email = docs.documents[0]["email"];
        global.photoURL = docs.documents[0]["photoURL"];




        print("usetname and docc");
        print(obj.usname);
        print(obj.userdoc);


          Firestore.instance
              .collection("users")
              .where("uid", isEqualTo: user.uid)
              .getDocuments()
              .then((docs) {
            String userdoc;
            userdoc = docs.documents[0].documentID.toString();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ));
            print('Signed in : ${user.uid}');
          });
        }
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
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: Icon(
                    Icons.restaurant,
                    color: Colors.black,
                    size: _iconAnimation.value * 60.0,
                  )),
              new Padding(padding: EdgeInsets.all(10.0)),
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
                    padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration:
                                new InputDecoration(hintText: "Enter UserID"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (String value) =>
                                value.isEmpty ? "Enter EmailID" : null,
                            onSaved: (String value) => _emailID = value,
                          ),
                          new Padding(padding: EdgeInsets.only(top: 5.0)),
                          new TextFormField(
                            obscureText: true,
                            decoration:
                                new InputDecoration(hintText: "Enter Password"),
                            keyboardType: TextInputType.text,
                            validator: (String value) =>
                                value.isEmpty ? "Enter password" : null,
                            onSaved: (String value) => _password = value,
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new RaisedButton(
                        color: Colors.white,
                        onPressed: validatesubmit,
                        child: new Text(
                          "LOGIN",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                      new RaisedButton(
                        color: Colors.white,
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp())),
                        child: new Text(
                          "Sign Up",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ]),
              ),
            ]),
          ],
        ));
  }
}

/*

PAYMENT PAYTM

void validateAndSave() {
    final form = _newkey.currentState;
    form.save();
    if (form.validate()) if (sel != null) {
      print("valid" + "$_bm,$_cc,$_prn,$_od,$sel");
      Firestore.instance
          .collection('Attendies')
          .document('${U.data.data["SDate"]}')
          .setData({
        '${U.user.email}': {
          'Uid': 'Udb/${U.user.uid}',
          'VehicleType': '$sel',
          'Model': '$_bm',
          'CC': '$_cc',
          'Pillion': '$_prn',
          'Other': '$_od'
        },
      }, merge: true);
      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull('${U.data.data["PayUrl"]}',),
          package: 'com.android.chrome');
      intent.launch();
      MyNavigator.goToHome(context);
    } else
      print("Invalid");
}
 */
