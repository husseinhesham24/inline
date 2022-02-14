import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/confirm_screen.dart';
import '../screens/services_screen.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'getProviders_api.dart';
import 'google_signin_api.dart';

class GetUsersApi {
  static Future<void> checkUser(
    String endPoint,
    bool iswallet,
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

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      data = jsonDecode(response.body);
    } else {
      data = jsonDecode(response.body);
    }

    if (data['status']) {
      if (!iswallet) {
        Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return Services_Screen();
            },
          ),
        );
      } else {
        print("wallet 3yat");
        final userObject = new User(
          userData.name,
          userData.email,
          userData.phone,
          userData.photo,
          userData.token,
          int.parse(data['user']['wallet']),
          userData.isGoogle,
          userData.isFacebook,
        );

        String UserData = jsonEncode(userObject);
        UserSharedPreferences.setString('userData', UserData);
        Navigator.of(ctx).push(
          MaterialPageRoute(
            builder: (_) {
              return Confirm_Screen(data['user']['wallet']);
            },
          ),
        );
      }
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
