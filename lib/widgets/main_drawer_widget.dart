import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:inline/api/logout_api.dart';
import '../api/google_signin_api.dart';
import '../screens/login_screen.dart';
import '../modules/user.dart';
import '../widgets/draweritem_widget.dart';
import 'package:http/http.dart' as http;
import 'drawer_header_widget.dart';

class MainDrawer extends StatelessWidget {
  final User userData;

  MainDrawer(this.userData);

  void signOut(BuildContext ctx) {
    LogoutApi.logout(
      ctx,
      userData,
      "https://inline.mrtechnawy.com/api/auth/logout",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Drawer_Header(
            userData,
          ),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Your Reservations", Icons.book_online, null),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Wallet", Icons.money, null),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Settings", Icons.settings, null),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Sign out", Icons.logout, signOut),
        ],
      ),
    );
  }
}
