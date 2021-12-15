import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => runApp(new MaterialApp(
            debugShowCheckedModeBanner: false, home: LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    body: Stack(
    fit: StackFit.expand,
    children: <Widget>[
    new Container(
    color: Colors.white,
    ),
    new Opacity(
    opacity: 0.40,
            alwaysIncludeSemantics: true,
            child: new Image(
              fit: BoxFit.cover,
              image: new AssetImage("assets/food.jpg"),
              color: Colors.white,
              colorBlendMode: BlendMode.softLight,
            ),
          ),

          /*Container(
            decoration: BoxDecoration(color: Colors.white),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.black87,
                          radius: 60.0,
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.white,
                            size: 50.0,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                      ),
                      Text(
                        "APPetite",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 6.0,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Text("The perfect app for your appetite.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
