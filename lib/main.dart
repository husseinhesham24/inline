import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xff5A8D40),
        statusBarColor: Color(0xff5A8D40),
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Inline',
      theme: ThemeData(
        primaryColor: Color(0xff5A8D40),
        backgroundColor: Color(0xfff7f7f7),
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
            ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
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
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "GET START",
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(78),
                    ),
                    color: Color(0xffC4C4C4),
                    minWidth: 185,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
