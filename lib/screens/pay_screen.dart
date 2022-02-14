import 'package:flutter/material.dart';
import '../screens/Final_Screen.dart';
import '../screens/services_screen.dart';
import '../widgets/paragraph_widget.dart';
import '../widgets/button_widget.dart';

class Pay_Screen extends StatelessWidget {
  void navToFinalPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Final_Screen();
        },
      ),
    );
  }

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Services_Screen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              Paragraph_Widget("Your Services Costs: ", "5 Points"),
              SizedBox(
                height: 30,
              ),
              Paragraph_Widget("Waiting queue: ", "4 people"),
              SizedBox(
                height: 30,
              ),
              Paragraph_Widget("Current Turn: ", "2"),
              SizedBox(
                height: 150,
              ),
              Button_Widget("Confirm your reservation", navToFinalPage),
            ],
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


