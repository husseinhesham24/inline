import 'package:flutter/material.dart';
import '../screens/Final_Screen.dart';
import '../screens/services_screen.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/main_drawer_widget.dart';
import '../widgets/paragraph_widget.dart';
import '../widgets/button_widget.dart';

class Pay_Screen extends StatefulWidget {
  final String waiting, currentTurn, cost;
  Pay_Screen(this.waiting, this.currentTurn, this.cost);

  @override
  State<Pay_Screen> createState() => _Pay_ScreenState();
}

class _Pay_ScreenState extends State<Pay_Screen> {
  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          drawer: MainDrawer(),
          appBar: appBar_Widget(() {}, true),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Paragraph_Widget("Your Service Cost: ", widget.cost),
                SizedBox(
                  height: 30,
                ),
                Paragraph_Widget("Waiting queue: ", "${widget.waiting} people"),
                SizedBox(
                  height: 30,
                ),
                Paragraph_Widget("Current Turn: ", widget.currentTurn),
                SizedBox(
                  height: 150,
                ),
                Button_Widget("Confirm your reservation", () {}),
              ],
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
