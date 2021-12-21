import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../api/social_api.dart';
import '../api/google_signin_api.dart';
import '../screens/signing_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_widget.dart';
import '../widgets/input_widget.dart';
import '../api/login_api.dart';

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
      "assets/images/unknown.png",
      context,
    );
  }

  Future googleAuth(BuildContext ctx) async {
    try {
      final user = await GoogleSignInApi.login();
      SocialApi.login(
        user!.displayName,
        user.email,
        user.photoUrl??"assets/images/unknown.png",
        true,
        false,
        ctx,
      );
    } catch (e) {
      print("throw google sgin in $e");
    }
  }

  Future facbookAuth(BuildContext ctx) async {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((user) {
        SocialApi.login(
          user["name"],
          user["email"],
          user["picture"]["data"]["url"],
          false,
          true,
          ctx,
        );
      });
    });
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
    // return LayoutBuilder(
    //   builder: (ctx, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
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
      //},
    //);
  }
}
