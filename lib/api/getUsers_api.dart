import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/services_screen.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'getProviders_api.dart';
import 'google_signin_api.dart';

class GetUsersApi {
  static Future<void> checkUser(
    String endPoint,
    BuildContext ctx,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    final response = await http.get(
      Uri.parse(endPoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("check login data");
    print(response.body);

    final data;

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      data = jsonDecode(response.body);
    } else {
      data = jsonDecode(response.body);
    }

    if (data['status']) {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return Services_Screen();
          },
        ),
      );
    } else {
      if (userData.isGoogle) {
        await GoogleSignInApi.logout();
      }

      if (userData.isFacebook) {
        await FacebookAuth.instance.logOut();
      }
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return Signing_Screen();
          },
        ),
      );
    }
  }
}
