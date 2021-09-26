import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inline/api/social_api.dart';
import '../api/google_signin_api.dart';
import '../modules/user.dart';
import '../screens/services_screen.dart';
import '../screens/signing_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_widget.dart';
import '../widgets/input_widget.dart';
import '../api/login_api.dart';
import 'package:http/http.dart' as http;

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  void inlineAuth(BuildContext ctx) {
    LoginApi.login(
      _username.text,
      _password.text,
      context,
    );
  }

  Future googleAuth(BuildContext ctx) async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sign in field',
          ),
        ),
      );
    } else {
      SocialApi.login(
        user.displayName,
        user.email,
        user.photoUrl,
        true,
        false,
        ctx,
      );
    }
  }

  void facbookAuth() {
    // check username and password from facebook auth but know let's move on
  }

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Signing_Screen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //padding: EdgeInsets.only(bottom: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 320,
                    width: 320,
                  ),
                  Input_Widget(
                    "Username",
                    _username,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget(
                    "Password",
                    _password,
                    null,
                    TextInputType.text,
                    null,
                    true,
                    true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Button_Widget(
                    "LOGIN",
                    inlineAuth,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon_Widget("assets/images/photo6.png", facbookAuth),
                        SizedBox(
                          width: 30,
                        ),
                        Icon_Widget("assets/images/photo10.png", googleAuth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => navToBack(context),
                  icon: Icon(Icons.arrow_back_ios_sharp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
