import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/logout_api.dart';
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
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Confirm_Screen();
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
