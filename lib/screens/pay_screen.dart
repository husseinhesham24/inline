import 'package:flutter/material.dart';
import 'package:inline/api/reserve_api.dart';
import '../api/getQueue_api.dart';
import '../screens/Final_Screen.dart';
import '../screens/services_screen.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/main_drawer_widget.dart';
import '../widgets/paragraph_widget.dart';
import '../widgets/button_widget.dart';

class Pay_Screen extends StatefulWidget {
  String waiting, currentTurn, cost;
  int branches_id, services_id;
  Pay_Screen(
    this.waiting,
    this.currentTurn,
    this.cost,
    this.branches_id,
    this.services_id,
  );

  @override
  State<Pay_Screen> createState() => _Pay_ScreenState();
}

class _Pay_ScreenState extends State<Pay_Screen> {
  void _reserve(BuildContext ctx) {
    ReserveApi.Reserve(
      widget.branches_id,
      widget.services_id,
      ctx,
    );
  }

  void _updateList(BuildContext ctx) {
    GetQueueApi.getQueue(
      "https://inline.mrtechnawy.com/api/branch/current-turn",
      widget.branches_id,
      widget.services_id,
      widget.cost,
      ctx,
      true,
      _refresh,
    );
  }

  void _refresh(String cost, String waiting, String current) {
    setState(() {
      widget.cost = cost;
      widget.currentTurn = current;
      widget.waiting = waiting;
    });
  }

  void _navToBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          drawer: MainDrawer(),
          appBar: appBar_Widget(_updateList, true),
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
                Button_Widget("Confirm your reservation", _reserve),
              ],
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
      },
    );
  }
}
