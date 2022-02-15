import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:inline/modules/reservation.dart';
import 'package:inline/screens/reservation_screen.dart';
import 'package:inline/screens/services_screen.dart';
import '../modules/branch.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'google_signin_api.dart';

class GetReservationApi {
  static Future<void> reservation(
    String endPoint,
    BuildContext ctx,
    bool isnav,
    Function setData,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);

    final response = await http.get(
      Uri.parse('${endPoint}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("reservation data");
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
      List<Reservation> reservationList = [];
      //print("loop ya beh");
      data['result'].forEach((entry) {
        // print(
        //     'id=${entry['id']}\nname=${entry['name']}\nimage=${entry['image']}');
        reservationList.add(Reservation(
          branch_name: entry['branch_name'],
          service_name: entry['service_name'],
          current_turn: entry['current_turn'],
          queue: entry['queue'],
          my_turn: entry['my_turn'],
        ));
      });

      final String encodedData = Reservation.encode(reservationList);
      UserSharedPreferences.setString('reservationData', encodedData);

      if (isnav) {
        Navigator.of(ctx).push(
          MaterialPageRoute(
            builder: (_) {
              return Reserve_Screen();
            },
          ),
        );
      } else {
        setData();
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
