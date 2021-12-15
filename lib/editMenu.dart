import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appetite/MenuBedit.dart';
import 'package:appetite/loginscreen.dart';
import 'package:appetite/COhome.dart';
import 'package:appetite/COorderhis.dart';
import 'package:appetite/LVedit.dart';
import 'package:appetite/NVedit.dart';
import 'package:appetite/bevedit.dart';

class editMenu extends StatefulWidget {
  @override
  _editMenuState createState() => _editMenuState();
}

class _editMenuState extends State<editMenu> {
  @override
  int _selectedPage = 0;
  var _pageOptions = [
    MenuBedit(),
    LVedit(),
    NVedit(),
    bevedit(),
    //MenuNVedit(),//MenuL(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          title: new Text(
            "Edit Menu",
            style: new TextStyle(color: Colors.white),
          ),
        ),
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
                      "Tanmay",
                      style: TextStyle(color: Colors.black),
                    ),
                    accountEmail: new Text(
                      'rand@gmail',
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
                      splashColor: Colors.tealAccent,
                      child: new ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => COhomepage()));
                        },
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
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => editMenu()));
                    },
                    leading: new Icon(
                      Icons.mode_edit,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: new Text(
                      "Edit Menu",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                  new ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CanOrders()));
                    },
                    leading: new Icon(
                      Icons.history,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    title: new Text(
                      "Order History",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                  new Divider(
                    color: Colors.white70,
                  ),
                  new ListTile(
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((val) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
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
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black87,
          ),
          child: Container(
            height: 58.0,
            child: BottomNavigationBar(
                currentIndex: _selectedPage,
                onTap: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'Breakfast',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'LunchVeg',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'Lunchnonveg',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_bar,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    title: Text(
                      'beverages',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
