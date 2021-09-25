import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inline/widgets/draweritem_widget.dart';

import 'drawer_header_widget.dart';

class MainDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final dynamic userPhoto;

  MainDrawer(this.userName, this.userEmail, this.userPhoto);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Drawer_Header(userName, userEmail, userPhoto),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Your Reservations", Icons.book_online),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Wallet", Icons.money),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Settings", Icons.settings),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Sign out", Icons.logout),
        ],
      ),
    );
  }
}
