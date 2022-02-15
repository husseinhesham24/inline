import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inline/api/getReservation_api.dart';
import 'package:inline/api/reserve_api.dart';
import 'package:inline/screens/reservation_screen.dart';
import '../api/getUsers_api.dart';
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

  void navToConfirmPage(BuildContext ctx) {
    GetUsersApi.checkUser(
      "https://inline.mrtechnawy.com/api/auth/user-profile",
      true,
      ctx,
    );
  }


  void navToReservePage(BuildContext ctx) async {
    GetReservationApi.reservation(
      "https://inline.mrtechnawy.com/api/reservation/mine",
      ctx,
      true,
      () {},
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
          DrawerItem("Your Reservations", Icons.book_online, navToReservePage),
          SizedBox(
            height: 20,
          ),
          DrawerItem("Wallet", Icons.money, navToConfirmPage),
          SizedBox(
            height: 20,
          ),
          // DrawerItem("Settings", Icons.settings, null),
          // SizedBox(
          //   height: 20,
          // ),
          DrawerItem("Sign out", Icons.logout, signOut),
        ],
      ),
    );
  }
}
