import 'package:blood_app/api/users_api.dart';
import 'package:blood_app/screens/donors.dart';
import 'package:blood_app/screens/profile_screens/edit_profile.dart';
import 'package:blood_app/screens/profile_screens/profile_body.dart';
import 'package:blood_app/screens/profile_screens/security.dart';
import 'package:blood_app/screens/welcome_screen.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController _tabController;
  double height;
  double width;
  var profileBodyUser;
  var _initialUserInfo;
  bool update;

  _updateProfile() {
    print("updated");
    setState(() {
      if (update == null) {
        update = false;
      }
      update = !update;
    });
    print("update finish");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _initialUserInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == 401) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          }
          if (!snapshot.hasError && snapshot.data != null) {
            var user = snapshot.data;
            profileBodyUser = snapshot.data;
            return Scaffold(
              backgroundColor: SharedUI.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Blood Bank",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 28),
                ),
                backgroundColor: SharedUI.white,
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (ctx) => Donors())),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: SharedUI.gray,
                          size: 32,
                        ),
                        SizedBox(
                          width: width * 0.04,
                        )
                      ],
                    ),
                  )
                ],
                bottom: buildTabBar(),
              ),
              body: TabBarView(
                children: [
                  ProfileBody(
                    user,
                    update: update,
                  ),
                  EditProfile(
                    user,
                    updateCallback: _updateProfile,
                  ),
                  Security()
                ],
                controller: _tabController,
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text("Check your network connection"),
              ),
            );
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      labelColor: SharedUI.red,
      indicatorColor: SharedUI.red,
      unselectedLabelColor: SharedUI.lightGray,
      indicatorWeight: 3.5,
      tabs: [
        Tab(
          icon: Icon(Icons.person),
          text: 'Profile',
        ),
        Tab(
          icon: Icon(Icons.edit_rounded),
          text: 'Edit profile',
        ),
        Tab(
          icon: Icon(Icons.shield),
          child: Text("Security"),
        ),
      ],
      controller: _tabController,
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _initialUserInfo = UserApi().fetchUserInfo();
    super.initState();
  }
}
