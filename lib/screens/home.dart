import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../modules/user.dart';
import '../modules/user_shared_Preferences.dart';
import '../widgets/button_widget.dart';
import './Signing_Screen.dart';
import 'package:http/http.dart' as http;

import 'services_screen.dart';

class MyHomePage extends StatelessWidget {
  late final data;

  Future<void> checkLoggedIn(
    String token,
    String photoUrl,
    bool isGoogle,
    bool isFacebook,
    BuildContext ctx,
  ) async {
    final response = await http.get(
      Uri.parse('https://inline.mrtechnawy.com/api/auth/user-profile'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
    );

    print("check login data");
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      data = jsonDecode(response.body);
    } else {
      data = jsonDecode(response.body);
    }

    print(data);
    print(photoUrl);
    if (data['status']) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            final userData = new User(
              data['user']['name'],
              data['user']['email'],
              data['user']['phone_number'],
              photoUrl,
              token,
              isGoogle,
              isFacebook,
            );
            return Services_Screen(userData);
          },
        ),
      );
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

  void navToSigningPage(BuildContext ctx) async {
    final String? token = UserSharedPreferences.getString('token');
    final String? photo = UserSharedPreferences.getString('photo');
    final bool? isGoogle = UserSharedPreferences.getBool('isGoogle');
    final bool? isFacebook = UserSharedPreferences.getBool('isFacebook');
    print(token);
    print(photo);
    if (token != null) {
      print("7mo");
      checkLoggedIn(token, photo ?? "assets/images/unknown.png",
          isGoogle ?? false, isFacebook ?? false, ctx);
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
