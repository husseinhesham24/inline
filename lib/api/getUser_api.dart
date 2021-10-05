import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inline/screens/home.dart';
import 'package:inline/screens/services_screen.dart';
import 'package:inline/screens/signing_screen.dart';
import '../modules/user.dart';
import '../modules/user_shared_Preferences.dart';
import '../widgets/button_widget.dart';
import 'package:http/http.dart' as http;

class GetUserApi {
  static Future<void> checkUser(
    String token,
    String photoUrl,
    bool isGoogle,
    bool isFacebook,
    String endPoint,
    BuildContext ctx,
  ) async {
    final response = await http.get(
      Uri.parse(endPoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
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

    print(data);
    print(photoUrl);
    if (data['status']) {
      final userData = new User(
        data['user']['name'],
        data['user']['email'],
        data['user']['phone_number'],
        photoUrl,
        token,
        int.parse(data['user']['wallet']),
        isGoogle,
        isFacebook,
      );

      MyHomePage.getUser(ctx, userData);
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
}
