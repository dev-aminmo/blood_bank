import 'package:blood_app/screens/donors.dart';
import 'package:blood_app/screens/profile_screens/edit_profile.dart';
import 'package:blood_app/screens/profile_screens/profile_body.dart';
import 'package:blood_app/screens/profile_screens/security.dart';
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

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: SharedUI.white,
      appBar: AppBar(
        title: Text(
          "Blood Bank",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 28),
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
        children: [ProfileBody(), EditProfile(), Security()],
        controller: _tabController,
      ),
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
    super.initState();
  }
}
