import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/google_signin_api.dart';
import '../screens/login_screen.dart';
import '../modules/user.dart';
import '../widgets/draweritem_widget.dart';
import 'package:http/http.dart' as http;
import 'drawer_header_widget.dart';

class MainDrawer extends StatelessWidget {
  final User userData;

  MainDrawer(this.userData);

  Future<void> signOut(BuildContext ctx) async {
    final response = await http.post(
      Uri.parse('https://inline.mrtechnawy.com/api/auth/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print(response.body);
    final data;
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      data = jsonDecode(response.body);
    } else {
      data = jsonDecode(response.body);
    }

    // if conds of google & facebook
    if (userData.isGoogle) {
      await GoogleSignInApi.logout();
    }
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Login_Screen();
    }));
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
