import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/services_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;

class SignUpApi {
  static Future<void> signup(
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String phoneNumber,
    String dateOfBirth,
    String photo,
    Function getData,
    bool isGoogle,
    bool isFacebook,
    BuildContext ctx,
  ) async {
    final response = await http.post(
      Uri.parse('https://inline.mrtechnawy.com/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth,
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

    print(data['status']);
    if (data['status']) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            final userObject = new User(
              data['user']['name'],
              data['user']['email'],
              data['user']['phone_number'],
              photo,
              data['access_token'],
              int.parse(data['user']['wallet']),
              isGoogle,
              isFacebook,
            );

            String UserData = jsonEncode(userObject);
            UserSharedPreferences.setString('userData', UserData);

            return Services_Screen();
          },
        ),
      );
    } else {
      getData(data);
    }
  }
}
