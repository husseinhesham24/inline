import 'package:flutter/material.dart';
import './login_screen.dart';
import './register_screen.dart';

class Signing_Screen extends StatelessWidget {
  void navToLoginPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Login_Screen();
        },
      ),
    );
  }

  void navToRegPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Register_Screen();
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
          // width: constraints.maxWidth,
          // height: constraints.maxHeight,
          padding: EdgeInsets.only(bottom: 200),
          child: Center(
            child: Container(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
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
                  FlatButton(
                    onPressed: () => navToLoginPage(context),
                    child: Text(
                      "LOGIN",
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(78),
                    ),
                    color: Color(0xffC4C4C4),
                    minWidth: 159,
                  ),

                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () => navToRegPage(context),
                    child: Text(
                      "SIGNUP",
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(78),
                    ),
                    color: Color(0xffC4C4C4),
                    minWidth: 159,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    //},
    //);
  }
}
