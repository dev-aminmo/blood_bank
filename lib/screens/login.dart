import 'package:blood_app/shared_ui/sharedui.dart';
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
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Login',
              style: SharedUI.textStyle(Colors.black).copyWith(fontSize: 28),
            ),
            Form(
                child: Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SharedUI.input('Email Address'),
                  SharedUI.input('Password'),
                  SharedUI.drawButton(width, height * 0.85, 'Log in'),
                  Text(
                    'OR',
                    style: SharedUI.textStyle(SharedUI.red),
                  ),
                  SharedUI.drawButton(width, height * 0.85, 'Log in'),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
