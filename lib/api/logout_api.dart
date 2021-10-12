import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:inline/modules/user.dart';
import 'package:inline/modules/user_shared_Preferences.dart';
import 'package:inline/screens/login_screen.dart';
import 'google_signin_api.dart';

class LogoutApi {
  static Future<void> logout(
      BuildContext ctx, String endPoint) async {
    Map<String,dynamic> jsondatais = jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);

    print("logout token");
    print(userData.token);
    final response = await http.post(
      Uri.parse(endPoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("logout respone");
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

    if (userData.isFacebook) {
      await FacebookAuth.instance.logOut();
    }

    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return Login_Screen();
    }));
  }
}
