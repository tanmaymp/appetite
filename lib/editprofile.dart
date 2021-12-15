import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appetite/globaluser.dart' as global;
import 'package:appetite/Cart.dart';
import 'package:appetite/MyOrders.dart';
import 'package:appetite/Help.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/ProfilePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editProfilePage extends StatefulWidget {
  @override
  _editProfilePageState createState() => _editProfilePageState();
}

class _editProfilePageState extends State<editProfilePage> {
  /*static var dispname;
  static var number;
  static var email;
*/
  var username = global.username;
  var email = global.email;
  var number = global.number;
  var photoURL = global.photoURL;
  FileImage img;

  final GlobalKey<FormState> fk = new GlobalKey<FormState>();

  UpdateProfileInfo() async {
    print("heree");
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var picname = user.uid;
    final StorageReference storeref =
        FirebaseStorage.instance.ref().child('profilepics/${picname}.jpg');
    StorageUploadTask task = storeref.putFile(img);
    task.onComplete.then((value) {
      print(value.ref.getDownloadURL());
      Firestore.instance
          .collection("users")
          .where("uid", isEqualTo: user.uid)
          .getDocuments()
          .then((d) {
        value.ref.getDownloadURL().then((url) {
          setState(() {
            global.photoURL = url.toString();
          });
          Firestore.instance
              .collection("users")
              .where("uid", isEqualTo: user.uid)
              .getDocuments()
              .then((d) {
            Firestore.instance
                .collection("users")
                .document(d.documents[0].documentID)
                .updateData({
              "photoURL": url.toString(),
            });
          });
        });
      });
    }).catchError((e) {
      print(e);
    });
    var docs = await Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: user.uid)
        .getDocuments();
    global.userdoc = docs.documents[0]["photoURL"];
    print(global.photoURL);
    setState(() {
      photoURL = global.photoURL;
    });
  }

  updatecredentials() {
    final fstate = fk.currentState;
    if (fstate.validate()) {
      fstate.save();
      Fluttertoast.showToast(
        msg: "Saved changes",
        backgroundColor: Colors.black45,
        textColor: Colors.white70,
        fontSize: 14.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //getdata();
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              new IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {}),
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
            backgroundColor: Colors.black87,
            title: new Text(
              "Edit Profile",
              style: new TextStyle(color: Colors.white),
            )),
        drawer: Container(
          width: 290.0,
          child: new Drawer(
            elevation: 10.0,
            child: Container(
              width: 10.0,
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text(
                      global.username,
                      style: TextStyle(color: Colors.black),
                    ),
                    accountEmail: new Text(
                      global.email,
                      style: TextStyle(color: Colors.black),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white70,
                    ),
                    currentAccountPicture: new GestureDetector(
                      child: new CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        child: new Icon(
                          Icons.account_circle,
                          size: 50.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      splashColor: Colors.white,
                      child: new ListTile(
                        onTap: () => Navigator.of(context).pop(),
                        leading: new Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        title: new Text(
                          "Home",
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                  new ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage())),
                    leading: new Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: new Text(
                      "Profile",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                  new ListTile(
                    onTap: () {
                      FirebaseAuth.instance.currentUser().then((us) {
                        Firestore.instance
                            .collection("users")
                            .where("uid", isEqualTo: us.uid)
                            .getDocuments()
                            .then((d) {
                          String str = d.documents[0].documentID.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrders()));
                        });
                      });
                    },
                    leading: new Icon(
                      Icons.fastfood,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: new Text(
                      "My Orders",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                  new Divider(
                    color: Colors.white70,
                  ),
                  new ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Help())),
                    leading: new Icon(
                      Icons.help_outline,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: new Text(
                      "Help",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                  new ListTile(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    leading: new Icon(
                      Icons.open_in_new,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: new Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
              ClipPath(
                  child: Container(
                    color: Colors.black87.withOpacity(0.8),
                  ),
                  clipper: getClipper()),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Container(
                          height: 300.0,
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Image(
                              width: 400.0,
                              height: 300.0,
                              fit: BoxFit.fill,
                              image: NetworkImage(photoURL)),
                        ),
                        FloatingActionButton(
                          onPressed: () => UpdateProfileInfo(),
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: const BeveledRectangleBorder(),
                          mini: true,
                          child: Icon(Icons.mode_edit),
                        )
                      ]),
                      Form(
                          key: fk,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  style: TextStyle(fontSize: 22.0),
                                  initialValue: global.username,
                                  keyboardType: TextInputType.text,
                                  validator: (String value) =>
                                      value.isEmpty ? "Enter username" : null,
                                  onSaved: (String value) =>
                                      global.username = value,
                                ),
                                TextFormField(
                                  style: TextStyle(fontSize: 22.0),
                                  initialValue: global.number,
                                  keyboardType: TextInputType.number,
                                  validator: (String value) =>
                                      value.length != 10
                                          ? "Enter valid number"
                                          : null,
                                  onSaved: (String value) =>
                                      global.number = value,
                                ),
                                TextFormField(
                                  style: TextStyle(fontSize: 22.0),
                                  initialValue: global.email,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) =>
                                      !value.contains("@")
                                          ? "Enter valid email"
                                          : null,
                                  onSaved: (String value) =>
                                      global.email = value,
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => updatecredentials(),
                            child: Text("Save"),
                            color: Colors.black87,
                            textColor: Colors.white,
                          ),
                          SizedBox(width: 10.0),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            },
                            color: Colors.white,
                            textColor: Colors.black87,
                            child: Text("Cancel"),
                          )
                        ],
                      )
                    ]),
              ),
            ]));
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
