import 'package:flutter/material.dart';
import 'package:inline/api/charge_api.dart';

import '../widgets/appBar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/main_drawer_widget.dart';

class ChargeWallet_Widget extends StatefulWidget {
  @override
  _ChargeWallet_WidgetState createState() => _ChargeWallet_WidgetState();
}

class _ChargeWallet_WidgetState extends State<ChargeWallet_Widget> {
  final _costController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expMonthController = TextEditingController();
  final _expYearController = TextEditingController();
  final _cvcController = TextEditingController();

  void _navToBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _chargeWallet(BuildContext ctx) {
    final enteredcost = _costController.text;
    final enteredcardNumber = _cardNumberController.text;
    final enteredexpMonth = _expMonthController.text;
    final enteredexpYear = _expYearController.text;
    final cvc = _cvcController.text;

    ChargeApi.charge(
      enteredcost,
      enteredcardNumber,
      enteredexpMonth,
      enteredexpYear,
      cvc,
      ctx,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: appBar_Widget((){}, true),
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(top: 20),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Input_Widget(
                    "Cost",
                    _costController,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Input_Widget(
                    "Card number",
                    _cardNumberController,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Input_Widget(
                    "Expired Month",
                    _expMonthController,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Input_Widget(
                    "Expired Year",
                    _expYearController,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Input_Widget(
                    "cvc",
                    _cvcController,
                    null,
                    TextInputType.text,
                    null,
                    false,
                    false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Button_Widget(
                    "Charge",
                    _chargeWallet,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
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
    );
  }
}
