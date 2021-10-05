import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inline/api/getUser_api.dart';
import '../modules/user.dart';
import '../modules/user_shared_Preferences.dart';
import '../widgets/button_widget.dart';
import './Signing_Screen.dart';
import 'package:http/http.dart' as http;

import 'services_screen.dart';

class MyHomePage extends StatelessWidget {
  static void getUser(
    BuildContext ctx,
    dynamic userData,
  ) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Services_Screen(userData);
        },
      ),
    );
  }

  void navToSigningPage(BuildContext ctx) async {
    final String? token = UserSharedPreferences.getString('token');
    final String? photo = UserSharedPreferences.getString('photo');
    final bool? isGoogle = UserSharedPreferences.getBool('isGoogle');
    final bool? isFacebook = UserSharedPreferences.getBool('isFacebook');
    print(token);
    print(photo);
    if (token != null) {
      print("7mo");
      GetUserApi.checkUser(
          token,
          photo ?? "assets/images/unknown.png",
          isGoogle ?? false,
          isFacebook ?? false,
          "https://inline.mrtechnawy.com/api/auth/user-profile",
          ctx);
    } else {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return Signing_Screen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: EdgeInsets.only(bottom: 200),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 320,
                      width: 320,
                    ),
                    // ignore: deprecated_member_use
                    Button_Widget("GET START", navToSigningPage),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
