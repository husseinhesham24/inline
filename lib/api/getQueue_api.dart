import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:inline/screens/services_screen.dart';
import '../modules/branch.dart';
import '../modules/service.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'google_signin_api.dart';

class GetQueueApi {
  static Future<void> getQueue(
    String endPoint,
    int branch_id,
    int service_id,
    String cost,
    BuildContext ctx,
    bool isnav,
    Function setData,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    //print("lon=${lon}\nlat=${lat}");

    final response = await http.get(
      Uri.parse('${endPoint}?branch_id=${branch_id}&service_id=${service_id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("queue data");
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
      print("y5vbet el4lal");
      if (!isnav) {
        print("y5vbet el4laloooo");
        setData(
          ctx,
          data['result']['queue'],
          data['result']['current_turn'],
          cost,
          branch_id,
          service_id,
        );
      } else {
        print("y5vbet el4lalxxxxx");
        setData(
          cost,
          data['result']['queue'],
          data['result']['current_turn'],
        );
      }
    } else {
      final snackBar = SnackBar(
        content: const Text('Sorry, there is something wrong :)'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }
}
