import 'package:flutter/material.dart';
import 'package:appetite/Menulunch.dart';
import 'package:appetite/MenuLunchNV.dart';
import 'package:appetite/Thalis.dart';

class lunchOptions extends StatefulWidget {
  @override
  _lunchOptionsState createState() => _lunchOptionsState();
}

class _lunchOptionsState extends State<lunchOptions> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(

          //mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => thali())),
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          //backgroundBlendMode: BlendMode.lighten,
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.white54, BlendMode.lighten),
                              image:
                                  AssetImage("assets/vpav                .jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      "THALI",
                      style: TextStyle(fontSize: 28.0),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MenuL()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          //backgroundBlendMode: BlendMode.lighten,
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.white54, BlendMode.lighten),
                              image: AssetImage("assets/frice.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      "VEG",
                      style: TextStyle(fontSize: 28.0),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuN()));
                },
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          //backgroundBlendMode: BlendMode.lighten,
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.white54, BlendMode.lighten),
                              image: AssetImage("assets/cbhel.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Center(
                          child: Text(
                        "NON VEG",
                        style: TextStyle(fontSize: 28.0),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
