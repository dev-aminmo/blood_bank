import 'package:blood_app/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:blood_app/shared_ui/sharedui.dart';

class btn {
  String btn_text1;
  String btn_text2;
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<String> _buttonTextWelcome = ['Be a donor', 'Search for a donor'];
  List<String> _buttonTextAuth = ['Log in', 'Sign up'];
  bool _isSeen = false;
  List<Widget> widgets;
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    List<Widget> widgets = [
      SharedUI.drawButton(
        width,
        height,
        _buttonTextAuth[0],
      ),
      SizedBox(
        height: height * 0.02,
      ),
      SharedUI.drawButton(
        width,
        height,
        _buttonTextAuth[1],
        bgColor: SharedUI.white,
        textColor: SharedUI.red,
      ),
      SizedBox(
        height: height * 0.07,
      ),
    ];

    return Stack(
      children: [
        SharedUI.myBackgroundImage,
        SizedBox.expand(
          child: (!_isSeen)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                    ),
                    SharedUI.drawButton(
                      width,
                      height,
                      _buttonTextAuth[0],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedUI.drawButton(width, height, _buttonTextAuth[1],
                        bgColor: SharedUI.white,
                        textColor: SharedUI.red, event: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    }),
                    SizedBox(
                      height: height * 0.07,
                    )

                    /**/
                    /*
                   SharedUI.drawButton(width, height, _buttonTextWelcome[0],
                      event: () {
                      setState(() {
                        _isSeen = true;
                      });
                    }),
              SizedBox(
                height: height * 0.02,
              ),
              SharedUI.drawButton(
                width,
                height,
                _buttonTextWelcome[1],
                bgColor: SharedUI.white,
                textColor: SharedUI.red,
              ),
              SizedBox(
                height: height * 0.07,
              ),
              */
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                    ),
                    SharedUI.drawButton(width, height, _buttonTextWelcome[0],
                        event: () {
                      setState(() {
                        _isSeen = true;
                      });
                    }),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SharedUI.drawButton(width, height, _buttonTextWelcome[1],
                        bgColor: SharedUI.white, textColor: SharedUI.red),
                    SizedBox(
                      height: height * 0.07,
                    )

                    /**/
                    /*
                   SharedUI.drawButton(width, height, _buttonTextWelcome[0],
                      event: () {
                      setState(() {
                        _isSeen = true;
                      });
                    }),
              SizedBox(
                height: height * 0.02,
              ),
              SharedUI.drawButton(
                width,
                height,
                _buttonTextWelcome[1],
                bgColor: SharedUI.white,
                textColor: SharedUI.red,
              ),
              SizedBox(
                height: height * 0.07,
              ),
              */
                  ],
                ),
        )
        // ExactAssetImage('assets/images/stock.jpg')
      ],
    );
  }
}
