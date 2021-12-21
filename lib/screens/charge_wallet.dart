import 'package:flutter/material.dart';

class ChargeWallet_Widget extends StatefulWidget {
  final Function chargeWallet;
  ChargeWallet_Widget(this.chargeWallet);

  @override
  _ChargeWallet_WidgetState createState() => _ChargeWallet_WidgetState();
}

class _ChargeWallet_WidgetState extends State<ChargeWallet_Widget> {
  final _costController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expMonthController = TextEditingController();
  final _expYearController = TextEditingController();

  void _submitData() {
    final enteredcost = _costController.text;
    final enteredcardNumber = _cardNumberController.text;
    final enteredexpMonth = _expMonthController.text;
    final enteredexpYear = _expYearController.text;

    widget.chargeWallet();
    Navigator.of(context).pop();
  }

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
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
                        "15 Points",
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
        );
      },
    );
  }
}
