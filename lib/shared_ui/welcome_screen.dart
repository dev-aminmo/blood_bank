import 'package:flutter/material.dart';
import 'package:blood_app/shared_ui/sharedui.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    Key key,
    @required this.height,
    @required this.width,
    @required this.buttonText1,
    @required this.buttonText2,
  }) : super(key: key);

  final double height;
  final double width;
  final String buttonText1;
  final String buttonText2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SharedUI.myBackgroundImage,
        SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              SharedUI.drawButton(width, height, buttonText1),
              SizedBox(
                height: height * 0.02,
              ),
              SharedUI.drawButton(width, height, buttonText2,
                  bgColor: SharedUI.white, textColor: SharedUI.red),
              SizedBox(
                height: height * 0.07,
              ),
            ],
          ),
        )
        // ExactAssetImage('assets/images/stock.jpg')
      ],
    );
  }
}
