import 'package:flutter/material.dart';

class SharedUI {
  static const Color red = Color(0xffD22E2B);
  static const Color white = Colors.white;
  static Widget myBackgroundImage = Stack(
    children: [
      SizedBox.expand(
          child: Image.asset(
        'assets/images/stock.jpg',
        fit: BoxFit.cover,
        alignment: Alignment(-0.4, 0),
      )),
      Opacity(
        opacity: 0.3,
        child: Container(
          color: red,
        ),
      ),
    ],
  );
  static Widget drawButton(double width, double height, String text,
      {Color textColor = white, Color bgColor = red}) {
    return SizedBox(
      width: width * 0.85,
      height: height * 0.1,
      child: Flexible(
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: textColor,
                fontSize: 24),
          ),
          color: bgColor,
          onPressed: () {},
        ),
      ),
    );
  }
}
