import 'dart:convert';
import 'package:flutter/material.dart';
import '../modules/user_shared_Preferences.dart';
import '../modules/user.dart';
import '../screens/services_screen.dart';
import 'package:http/http.dart' as http;

import 'getProviders_api.dart';

class LoginApi {
  static Future<void> login(
    String username,
    String password,
    String photo,
    BuildContext ctx,
  ) async {
    final response = await http.post(
      Uri.parse('https://inline.mrtechnawy.com/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
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

    // print(data);
    // print("lol");
    // print(_data?['user']?['photo']);
    if (data['status']) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            final userObject = new User(
              data['user']['name'],
              data['user']['email'],
              data['user']['phone_number'],
              "assets/images/unknown.png",
              data['access_token'],
              int.parse(data['user']['wallet']),
              false,
              false,
            );

            String UserData = jsonEncode(userObject);
            UserSharedPreferences.setString('userData', UserData);
            GetprovidersApi.getProviders(
              "banking",
              "https://inline.mrtechnawy.com/api/provider/all",
              ctx,
            );
            return Services_Screen();
          },
        ),
      );
    } else {
      final snackBar = SnackBar(
        content: const Text('Sorry, we could not find your account.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }
}
