import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedUI.white,
      body: Container(
        color: Colors.red,
      ),
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.edit_rounded),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
}
