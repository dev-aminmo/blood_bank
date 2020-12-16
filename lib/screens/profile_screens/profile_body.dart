import 'package:blood_app/api/users_api.dart';
import 'package:blood_app/models/user.dart';
import 'package:blood_app/screens/welcome_screen.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

const _propertyTextStyle = TextStyle(fontSize: 18, color: SharedUI.lightGray);
const _infoTextStyle = TextStyle(fontSize: 18);

class ProfileBody extends StatefulWidget {
  User user;
  bool update;

  ProfileBody(this.user, {this.update});

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with AutomaticKeepAliveClientMixin<ProfileBody> {
  double height;
  double width;
  Function updateCallback;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: FutureBuilder(
          future: (widget.update == null)
              ? Future(() => widget.user)
              : UserApi().fetchUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var user = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CircleAvatar(
                    radius: width / 4,
                    backgroundColor: SharedUI.lightGray,
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  _myCustomCard(
                      height,
                      width,
                      buildCardContent("Full name", user.fullName, "Email",
                          user.email, height, width)),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  _myCustomCard(
                      height,
                      width,
                      buildCardContent(
                          "Address",
                          user.municipal + " " + user.state,
                          "Phone number",
                          user.phoneNumber,
                          height,
                          width)),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  _myCustomCard(
                      height,
                      width,
                      buildCardContent(
                          "Blood Type",
                          user.bloodType,
                          "Birth date",
                          user.birthDay +
                              "/" +
                              user.birthMonth +
                              "/" +
                              user.birthYear,
                          height,
                          width)),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  SharedUI.drawButton(width, height * 0.7, 'Logout',
                      event: () async {
                    await UserApi().logOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  }),
                  SizedBox(
                    height: height * 0.04,
                  ),
                ],
              );
            } else
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.2,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator()),
                ],
              );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _myCustomCard(double height, double width, child) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: SharedUI.lightGray, offset: Offset(0, 0), blurRadius: 3)
        ]),
    child: child,
  );
}

Column buildCardContent(String property1, String value1, String property2,
    String value2, double height, double width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$property1:",
            style: _propertyTextStyle,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            "$value1",
            softWrap: true,
            style: _infoTextStyle,
          ),
        ],
      ),
      SizedBox(
        height: height * 0.01,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$property2:",
            style: _propertyTextStyle,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            "$value2",
            softWrap: true,
            style: _infoTextStyle,
          ),
        ],
      ),
    ],
  );
}
