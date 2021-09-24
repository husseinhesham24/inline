import 'dart:convert';

import 'package:flutter/material.dart';
import '../screens/services_screen.dart';
import '../screens/signing_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_widget.dart';
import '../widgets/input_widget.dart';
import 'package:http/http.dart' as http;

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  dynamic _data;

  Future<void> _createAlbum(
    String username,
    String password,
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

    //print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      _data = jsonDecode(response.body);
    } else {
      _data = jsonDecode(response.body);
    }

    _verfyLogin(ctx);
  }

  void _sendRequest(BuildContext ctx) {
    _createAlbum(
      _username.text,
      _password.text,
      ctx,
    );
  }

  void _verfyLogin(BuildContext ctx) {
    // print(_data);
    // print("lol");
    // print(_data['status']);
    if (_data['status']) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
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

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
                    "assets/images/logo.png",
                    height: 320,
                    width: 320,
                  ),
                  Input_Widget(
                    "Username",
                    _username,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget(
                    "Password",
                    _password,
                    null,
                    TextInputType.text,
                    null,
                    true,
                    true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Button_Widget("LOGIN", _sendRequest),
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
