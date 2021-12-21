import 'package:flutter/material.dart';
import 'package:inline/api/signup_api.dart';
import '../widgets/input_widget.dart';
import '../widgets/button_widget.dart';
import '../screens/signing_screen.dart';

dynamic data;

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
  dynamic _data = null;

  void _sendRequest(BuildContext ctx) {
    SignUpApi.signup(
      _name.text,
      _email.text,
      _password.text,
      _passwordConfirmation.text,
      _phoneNumber.text,
      _dateOfBirth.text,
      "assets/images/unknown.png",
      _getData,
      false,
      false,
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
          return Signing_Screen();
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
              "Name",
              _name,
              (_data == null || _data['status'])
                  ? null
                  : _data?['errors']?['name']?[0],
              TextInputType.text,
              "john doe",
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
              height: 30,
            ),
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
              "E-mail",
              _email,
              (_data == null || _data['status'])
                  ? null
                  : _data?['errors']?['email']?[0],
              TextInputType.emailAddress,
              "john@doe.com",
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
            Input_Widget(
              "Confirm Password",
              _passwordConfirmation,
              (_data == null || _data['status'])
                  ? null
                  : _data?['errors']?['password']?[0],
              TextInputType.text,
              null,
              true,
              true,
            ),
            SizedBox(
              height: 50,
            ),
            Button_Widget("Start", _sendRequest),
          ],
        ),
      ),
    );
  }
}
