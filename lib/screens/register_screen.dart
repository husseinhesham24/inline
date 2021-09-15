import 'package:flutter/material.dart';
import '../widgets/input_widget.dart';
import '../widgets/button_widget.dart';
import '../screens/signing_screen.dart';

class Register_Screen extends StatefulWidget {
  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  void startAction() {
    // check it is valid ot not first and add it to database
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
                  Input_Widget("First Name"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("Last Name"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("Date of Birth"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("Mobile Number"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("E-mail"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("Password"),
                  SizedBox(
                    height: 30,
                  ),
                  Input_Widget("Confirm Password"),
                  SizedBox(
                    height: 30,
                  ),
                  Button_Widget("Start", startAction),
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
