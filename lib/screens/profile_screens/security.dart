import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.07),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          SharedUI.input('Current Password'),
          SizedBox(
            height: height * 0.05,
          ),
          SharedUI.input('New Password'),
          SizedBox(
            height: height * 0.05,
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xff26FB81),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.check,
                      size: width * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    'at least 8 characters',
                    style: TextStyle(
                        color: Color(0xff26FB81),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                children: [
                  Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xff8FA0B3),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.check,
                      size: width * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    'have a capital letter',
                    style: TextStyle(
                        color: Color(0xff8FA0B3),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
