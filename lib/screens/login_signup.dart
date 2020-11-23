/*/*
import 'package:blood_app/screens/signup.dart';
import 'package:flutter/material.dart';
import '../shared_ui/welcome_screen.dart';

class Login_Signup extends StatefulWidget {
  @override
  _Login_SignupState createState() => _Login_SignupState();
}

class _Login_SignupState extends State<Login_Signup> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WelcomeScreen(
      height: height,
      width: width,
      buttonText1: 'Log in',
      buttonText2: 'Sign up',
      event2: _event2,
    );
  }

  _event2() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
  }
}
*/*/
