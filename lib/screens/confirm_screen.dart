import 'package:flutter/material.dart';
import '../screens/charge_wallet.dart';
import '../screens/services_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '../screens/Final_Screen.dart';
import '../screens/pay_screen.dart';

class Confirm_Screen extends StatelessWidget {
  final String wallet;
  Confirm_Screen(this.wallet);

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return Services_Screen();
        },
      ),
    );
  }

  void _startChargeWallet(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ChargeWallet_Widget();
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
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Button_Widget("Enter", navToFinalPage),
              // ),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Your Total Points in Wallet:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        wallet,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000000),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      //Input_Widget("Mobile Numbers"),
                      SizedBox(
                        height: 25,
                      ),
                      //Input_Widget("Enter the code"),
                    ],
                  ),
                ),
              ),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xff5A8D40),
            onPressed: () {
              _startChargeWallet(context);
            },
          ),
        );
      },
    );
  }
}
