import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/logout_api.dart';
import '../modules/user.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/confirm_screen.dart';
import '../widgets/draweritem_widget.dart';
import 'drawer_header_widget.dart';

class MainDrawer extends StatelessWidget {
  void signOut(BuildContext ctx) {
    LogoutApi.logout(
      ctx,
      "https://inline.mrtechnawy.com/api/auth/logout",
    );
  }

  void navToConfirmPage(BuildContext ctx) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Confirm_Screen(userData.wallet.toString());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Drawer_Header(),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Your Reservations", Icons.book_online, null),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Wallet", Icons.money, navToConfirmPage),
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
