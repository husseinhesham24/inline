import 'package:flutter/material.dart';
import '../screens/services_screen.dart';
import '../widgets/paragraph_widget.dart';
import '../screens/confirm_screen.dart';
import '../widgets/button_widget.dart';

class Pay_Screen extends StatelessWidget {
  const Pay_Screen({Key? key}) : super(key: key);

  void navToConfirmPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Confirm_Screen();
        },
      ),
    );
  }

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Services_Screen(null);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    Button_Widget("Confirm your reservation", navToConfirmPage),
              ),
              Paragraph_Widget("Your Services Costs:","5 Points"),
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


// Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: [
//                       Text(
//                         "Your Service Costs:",
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff000000),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "5 points",
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff000000),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Button_Widget(
//                       "Confirm your reservation", navToConfirmPage),
//                 ),
//               ],
//             ),
//           ),
