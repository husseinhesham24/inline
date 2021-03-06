import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:inline/screens/services_screen.dart';
import '../modules/branch.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/signing_screen.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;
import 'google_signin_api.dart';

class GetBranchesApi {
  static Future<void> getBranches(
    int id,
    String endPoint,
    double lat,
    double lon,
    BuildContext ctx,
    Function setData,
  ) async {
    Map<String, dynamic> jsondatais =
        jsonDecode(UserSharedPreferences.getString('userData')!);
    User userData = User.fromJson(jsondatais);
    print("lon=${lon}\nlat=${lat}");

    final response = await http.get(
      Uri.parse('${endPoint}?id=${id}&lat=${lat}&lon=${lon}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    print("branches list data");
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
      List<Branch> branchList = [];
      //print("loop ya beh");
      data['branches'].forEach((entry) {
        // print(
        //     'id=${entry['id']}\nname=${entry['name']}\nimage=${entry['image']}');
        branchList.add(Branch(id: entry['id'], name: entry['name']));
      });

      final String encodedData = Branch.encode(branchList);
      UserSharedPreferences.setString('branchData', encodedData);

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
