import 'dart:convert';
import 'package:flutter/material.dart';
import '../modules/user_shared_Preferences.dart';
import '../modules/user.dart';
import '../screens/confirm_screen.dart';
import '../screens/services_screen.dart';
import 'package:http/http.dart' as http;

import 'getProviders_api.dart';

class ChargeApi {
  static Future<void> charge(
    String cost,
    String cardNumber,
    String expMonth,
    String expYear,
    String cvc,
    BuildContext ctx,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    final response = await http.post(
      Uri.parse('https://inline.mrtechnawy.com/api/stripe/final-pay'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
      body: jsonEncode(<String, String>{
        'cost': cost,
        'card_number': cardNumber,
        'exp_month': expMonth,
        'exp_year': expYear,
        'cvc': cvc,
      }),
    );

    //print("lol wallet1");
    print(response.body);

    final data;

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      data = jsonDecode(response.body);
    } else {
      data = jsonDecode(response.body);
    }

    //print("lol wallet2");
    print(data);

    
    if (data['status']) {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            final userObject = new User(
              userData.name,
              userData.email,
              userData.phone,
              userData.photo,
              userData.token,
              data['result']['wallet'],
              userData.isGoogle,
              userData.isFacebook,
            );

            print("lol wallet");
            String UserData = jsonEncode(userObject);
            UserSharedPreferences.setString('userData', UserData);
            return Confirm_Screen(data['result']['wallet'].toString());
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
