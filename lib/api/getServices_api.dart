import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../modules/service.dart';
import '../modules/branch.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'google_signin_api.dart';

class GetServicesApi {
  static Future<void> getServices(
    int id,
    String endPoint,
    BuildContext ctx,
    Function setData,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);

    //final uri = Uri.https('https://inline.mrtechnawy.com', '/api/provider/all', queryParameters);
    final response = await http.get(
      Uri.parse('${endPoint}?id=${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("services list data");
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
      List<Service> serviceList = [];
      //print("loop ya beh");
      data['services'].forEach((entry) {
        // print(
        //     'id=${entry['id']}\nname=${entry['name']}\nimage=${entry['image']}');

        serviceList.add(Service(
          branches_id: int.parse(entry['pivot']['branches_id']),
          services_id: int.parse(entry['pivot']['services_id']),
          name: entry['name'],
          cost: entry['cost'],
        ));
      });

      final String encodedData = Service.encode(serviceList);
      UserSharedPreferences.setString('serviceData', encodedData);

      setData(ctx);
      // providerList.forEach((element) {
      //   print('id=${element.id}\nname=${element.name}\nimage=${element.photo}');
      // });
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
