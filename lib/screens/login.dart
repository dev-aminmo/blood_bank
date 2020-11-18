import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.1),
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Text(
              'Login',
              style: SharedUI.textStyle(Colors.black).copyWith(fontSize: 28),
            ),
            Form(
                child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SharedUI.input('Email Address'),
                        SharedUI.input('Password'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SharedUI.drawButton(width, height * 0.85, 'Log in'),
                        Text(
                          'OR',
                          style: SharedUI.textStyle(SharedUI.red),
                        ),
                        SharedUI.drawGoogleButton(
                            width, height, 'Log in with google'),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
