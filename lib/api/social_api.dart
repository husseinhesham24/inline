import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inline/screens/socialReg_screen.dart';
import '../modules/user.dart';
import '../screens/services_screen.dart';
import 'package:http/http.dart' as http;

class SocialApi {
  static Future<void> login(
    String? name,
    String email,
    String? photo,
    bool isGoogle,
    bool isFacebook,
    BuildContext ctx,
  ) async {
    final response = await http.post(
      Uri.parse('https://inline.mrtechnawy.com/api/auth/social'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

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
    print("lol");
    // print(_data?['user']?['photo']);
    if (data['status']) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            final userData = new User(
              data['user']['name'],
              data['user']['email'],
              data['user']['phone_number'],
              photo!,
              data['access_token'],
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
            return SocialReg_screen(
              name!,
              email,
              isGoogle,
              isFacebook,
            );
          },
        ),
      );
    }
  }
}
