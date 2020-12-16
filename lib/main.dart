import 'package:blood_app/screens/profile.dart';
import 'package:blood_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  Widget _screen;
  if (token == null) {
    _screen = WelcomeScreen();
  } else {
    _screen = Profile();
  }
  runApp(MyApp(_screen));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  Widget screen;

  MyApp(this.screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Bank',
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      home: screen,
    );
  }
}
