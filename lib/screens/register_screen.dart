import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/button_widget.dart';
import '../screens/signing_screen.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String name, String email, String password,
    String passwordConfirmation, String phoneNumber, String dateOfBirth) async {
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

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String name;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String updatedAt;
  final String createdAt;

  Album(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.updatedAt,
      required this.createdAt});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['user']['name'].toString(),
      email: json['user']['email'].toString(),
      phoneNumber: json['user']['phone_number'].toString(),
      dateOfBirth: json['user']['date_of_birth'].toString(),
      updatedAt: json['user']['updated_at'].toString(),
      createdAt: json['user']['created_at'].toString(),
    );
  }
}

class Register_Screen extends StatefulWidget {
  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirmation = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _dateOfBirth = TextEditingController();
  Future<Album>? _futureAlbum;

  void _startAction(BuildContext ctx) {
    setState(() {
      _futureAlbum = createAlbum(_name.text, _email.text, _password.text,
          _passwordConfirmation.text, _phoneNumber.text, _dateOfBirth.text);
    });
  }

  void _navToBack(BuildContext ctx) {
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
          body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child:
                  (_futureAlbum == null) ? buildStack() : buildFutureBuilder()),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => _navToBack(context),
                  icon: Icon(Icons.arrow_back_ios_sharp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stack buildStack() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Button_Widget("Start", _startAction),
        ),
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "First Name",
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
                            controller: _name,
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
                // SizedBox(
                //   height: 30,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: 60),
                //   child: Container(
                //     child: Row(
                //       children: [
                //         Container(
                //           width: 100,
                //           child: Text(
                //             "Last Name",
                //             style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //               color: Color(0xff000000),
                //             ),
                //           ),
                //         ),
                //         Container(
                //           width: 185,
                //           height: 50,
                //           child: TextField(
                //             style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //               color: Color(0xff000000),
                //             ),
                //             decoration: InputDecoration(
                //               fillColor: Color(0xffEEEAEA),
                //               filled: true,
                //               border: InputBorder.none,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Date of Birth",
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
                            controller: _dateOfBirth,
                            keyboardType: TextInputType.datetime,
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

                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Mobile Number",
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
                            controller: _phoneNumber,
                            keyboardType: TextInputType.phone,
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
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "E-mail",
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
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
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
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Confirm Password",
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
                            controller: _passwordConfirmation,
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
              ],
            ),
          ),
        ),
      ],
    );
  }

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
                Text(snapshot.data!.updatedAt),
                SizedBox(height: 20),
                Text(snapshot.data!.createdAt),
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
}
