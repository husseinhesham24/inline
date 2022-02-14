import 'dart:convert';
import 'package:flutter/material.dart';
import '../modules/user_shared_Preferences.dart';
import '../modules/user.dart';
import '../screens/confirm_screen.dart';
import '../screens/services_screen.dart';
import 'package:http/http.dart' as http;

import 'getProviders_api.dart';

class ReserveApi {
  static Future<void> Reserve(
    int branches_id,
    int services_id,
    BuildContext ctx,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    final response = await http.post(
      Uri.parse('https://inline.mrtechnawy.com/api/reservation/reserve'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
      body: jsonEncode(<String, String>{
        'branches_id': branches_id.toString(),
        'services_id': services_id.toString(),
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

    print("lol wallet");
    print(data);

    if (data['status']) {
      // final userObject = new User(
      //   userData.name,
      //   userData.email,
      //   userData.phone,
      //   userData.photo,
      //   userData.token,
      //   data['result']['wallet'],
      //   userData.isGoogle,
      //   userData.isFacebook,
      // );

      // String UserData = jsonEncode(userObject);
      // UserSharedPreferences.setString('userData', UserData);
      final snackBar = SnackBar(
        content: Text("Reserve successfully :)"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(data['message']),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }
}
