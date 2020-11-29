import 'package:blood_app/screens/login.dart';
import 'package:blood_app/screens/signup.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

import 'donors.dart';

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

    return Stack(
      children: [
        SharedUI.myBackgroundImage,
        SizedBox.expand(
            child: AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation =
                Tween<Offset>(begin: Offset(3, 0), end: Offset(0, 0));
            return FadeTransition(
                child: SlideTransition(
                    child: child, position: offsetAnimation.animate(animation)),
                opacity: animation);
          },
          child: (_isSeen)
              ? Column(
                  key: ValueKey(_isSeen),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                    ),
                    SharedUI.drawButton(width, height, _buttonTextAuth[0],
                        event: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }),
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
                  ],
                )
              : Column(
                  key: ValueKey(_isSeen),
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
                        bgColor: SharedUI.white,
                        textColor: SharedUI.red, event: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return Donors();
                      }));
                    }),
                    SizedBox(
                      height: height * 0.07,
                    )
                  ],
                ),
          duration: Duration(milliseconds: 850),
        ))
        // ExactAssetImage('assets/images/stock.jpg')
      ],
    );
  }
}
