import 'dart:convert';

import 'package:flutter/material.dart';
import '../screens/services_screen.dart';
import '../screens/signing_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_widget.dart';
import '../widgets/input_widget.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String username, String password) async {
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

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;

  Album({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['user']['id'],
      name: json['user']['name'].toString(),
      email: json['user']['email'].toString(),
      phoneNumber: json['user']['phone_number'].toString(),
      dateOfBirth: json['user']['date_of_birth'].toString(),
    );
  }
}

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}



class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _namename = TextEditingController();
  TextEditingController _password = TextEditingController();
  Future<Album>? _futureAlbum;

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Text(snapshot.data!.name),
                SizedBox(height: 20),
                Text(snapshot.data!.email),
                SizedBox(height: 20),
                Text(snapshot.data!.phoneNumber),
                SizedBox(height: 20),
                Text(snapshot.data!.dateOfBirth),
                SizedBox(height: 20),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  void _verfyLogin(BuildContext ctx) {
    setState(() {
      _futureAlbum = createAlbum(_namename.text, _password.text);
    });
  }

  void loginAction() {
    // check username and password from database but know let's move on
  }

  void googleAuth() {
    // check username and password from google auth but know let's move on
  }

  void facbookAuth() {
    // check username and password from facebook auth but know let's move on
  }

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Signing_Screen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //padding: EdgeInsets.only(bottom: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.jpeg",
                    height: 320,
                    width: 320,
                  ),
                  //Input_Widget("User name"),
                  Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Username",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            width: 185,
                            height: 50,
                            child: TextField(
                              controller: _namename,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xffEEEAEA),
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Input_Widget("Password"),
                  Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            width: 185,
                            height: 50,
                            child: TextField(
                              controller: _password,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xffEEEAEA),
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Button_Widget("LOGIN", _verfyLogin),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon_Widget("assets/images/photo6.png", googleAuth),
                        SizedBox(
                          width: 30,
                        ),
                        Icon_Widget("assets/images/photo10.png", facbookAuth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => navToBack(context),
                  icon: Icon(Icons.arrow_back_ios_sharp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}



