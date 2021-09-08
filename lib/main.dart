import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import './screens/home.dart';

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

