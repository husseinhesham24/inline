import 'package:flutter/material.dart';
import '../api/signup_api.dart';
import 'package:random_password_generator/random_password_generator.dart';
import '../screens/login_screen.dart';
import '../widgets/input_widget.dart';
import '../widgets/button_widget.dart';

dynamic data;

class SocialReg_screen extends StatefulWidget {
  final String name;
  final String email;
  final String photo;
  final bool isGoogle;
  final bool isFacebook;

  SocialReg_screen(
    this.name,
    this.email,
    this.photo,
    this.isGoogle,
    this.isFacebook,
  );

  @override
  _SocialReg_screenState createState() => _SocialReg_screenState();
}

class _SocialReg_screenState extends State<SocialReg_screen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  final password = RandomPasswordGenerator();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _dateOfBirth = TextEditingController();
  dynamic _data = null;

  void _sendRequest(BuildContext ctx) {
    String randPassword = password.randomPassword(
      letters: true,
      uppercase: true,
      numbers: true,
      specialChar: true,
      passwordLength: 100,
    );

    String randConPassword = randPassword;

    print("pass");
    print(randPassword);
    SignUpApi.signup(
      widget.name,
      widget.email,
      randPassword,
      randConPassword,
      _phoneNumber.text,
      _dateOfBirth.text,
      widget.photo,
      _getData,
      widget.isGoogle,
      widget.isFacebook,
      ctx,
    );
  }

  void _getData(dynamic data) {
    print("7mo");
    print(data);
    setState(() {
      _data = data;
    });
  }

  void _navToBack(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Login_Screen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 80),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: buildStack(),
          ),
        ),
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
      ),
    );
  }

  Container buildStack() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Input_Widget(
              "Mobile Number",
              _phoneNumber,
              (_data == null || _data['status'])
                  ? null
                  : _data?['errors']?['phone_number']?[0],
              TextInputType.phone,
              "123456789",
              false,
              false,
            ),
            SizedBox(
              height: 30,
            ),
            Input_Widget(
              "Date of Birth",
              _dateOfBirth,
              (_data == null || _data['status'])
                  ? null
                  : _data?['errors']?['date_of_birth']?[0],
              TextInputType.datetime,
              "9999-09-09",
              false,
              false,
            ),
            SizedBox(
              height: 100,
            ),
            Button_Widget("Start", _sendRequest),
          ],
        ),
      ),
    );
  }
}
