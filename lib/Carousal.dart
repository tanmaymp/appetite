import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Carousal extends StatefulWidget {
  @override
  _CarousalState createState() => _CarousalState();
}

class _CarousalState extends State<Carousal> {
  @override
  Widget image_car = Container(height: 150.0,
    child:Carousel(
    autoplayDuration: Duration(seconds: 5),
    dotBgColor: Colors.black12,
    dotSize: 4.0,
    dotIncreaseSize: 2.0,
    animationCurve: Curves.easeInOut,
    showIndicator: true,
    borderRadius: true,
    radius: Radius.circular(4.0),
    boxFit: BoxFit.cover,
    images: [
      AssetImage("assets/frice.jpg"),
      AssetImage("assets/vpav.jpg"),
      AssetImage("assets/coffee.jpg"),
      AssetImage("assets/chicken biryani.jpg"),
      AssetImage("assets/chicken singapore fried rice.jpg"),
    ],
  ));
  Widget build(BuildContext context) {
    return image_car;
  }
}
