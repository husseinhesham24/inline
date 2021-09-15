import 'package:flutter/material.dart';
import '../screens/services_screen.dart';
import '../screens/signing_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_widget.dart';
import '../widgets/input_widget.dart';

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  void navToServicesPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Services_Screen();
        },
      ),
    );
  }

  void loginAction() {
    // check username and password from database but know let's move on
  }

  void googleAuth() {
    // check username and password from google auth but know let's move on
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
                    "assets/images/logo.jpeg",
                    height: 320,
                    width: 320,
                  ),
                  Input_Widget("User name"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("Password"),
                  SizedBox(
                    height: 30,
                  ),
                  Button_Widget("LOGIN", navToServicesPage),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon_Widget("assets/images/photo6.png", googleAuth),
                        SizedBox(
                          width: 30,
                        ),
                        Icon_Widget("assets/images/photo10.png", facbookAuth),
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
