/**import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared_ui/welcome_screen.dart';

class On_BoardingScreen extends StatefulWidget {
  @override
  _On_BoardingScreenState createState() => _On_BoardingScreenState();
}

class _On_BoardingScreenState extends State<On_BoardingScreen> {
  Color red = Color(0xffD22E2B);
  Color white = Colors.white;
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return WelcomeScreen(
      height: height,
      width: width,
      buttonText1: 'Be a donor',
      buttonText2: 'Search for a donor',
    );
  }
}
**/
