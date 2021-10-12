import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../modules/provider.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'google_signin_api.dart';

class GetprovidersApi {
  static Future<void> getProviders(
    String targetList,
    String endPoint,
    BuildContext ctx,
    Function setData,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    //final uri = Uri.https('https://inline.mrtechnawy.com', '/api/provider/all', queryParameters);
    final response = await http.get(
      Uri.parse(endPoint + '?provider_type=${targetList}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("provider list data");
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
      List<Provider> providerList = [];
      //print("loop ya beh");
      data['providers'].forEach((entry) {
        // print(
        //     'id=${entry['id']}\nname=${entry['name']}\nimage=${entry['image']}');
        providerList.add(Provider(
            id: entry['id'], name: entry['name'], photo: entry['image']));
      });

      final String encodedData = Provider.encode(providerList);
      // print("encodedData");
      // print(encodedData);
      UserSharedPreferences.setString('providerData', encodedData);
      setData();
      // providerList.forEach((element) {
      //   print('id=${element.id}\nname=${element.name}\nimage=${element.photo}');
      // });
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
