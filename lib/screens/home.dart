import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/button_widget.dart';
import './Signing_Screen.dart';

class MyHomePage extends StatelessWidget {
  void navToSigningPage(BuildContext ctx) {
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
                      "assets/images/logo.jpeg",
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
