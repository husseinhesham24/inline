import 'package:flutter/material.dart';
import 'package:inline/modules/reservation.dart';
import 'package:inline/widgets/card_widget.dart';

import '../api/getReservation_api.dart';
import '../modules/user_shared_Preferences.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/main_drawer_widget.dart';

class Reserve_Screen extends StatefulWidget {
  @override
  _Reserve_ScreenState createState() => _Reserve_ScreenState();
}

class _Reserve_ScreenState extends State<Reserve_Screen> {
  List<dynamic> _foundList =
      Reservation.decode(UserSharedPreferences.getString('reservationData')!);

  void _updateList(BuildContext ctx) {
    GetReservationApi.reservation(
      "https://inline.mrtechnawy.com/api/reservation/mine",
      ctx,
      false,
      _refresh,
    );
  }

  void _refresh() {
    setState(() {
      _foundList = Reservation.decode(
          UserSharedPreferences.getString('reservationData')!);
    });
  }

  void _navToBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: appBar_Widget(_updateList, true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: _foundList.length > 0
                  ? ListView.builder(
                      itemCount: _foundList.length,
                      itemBuilder: (context, i) {
                        dynamic item = _foundList[i];

                        return Container(
                          height: 100,
                          child: Card_Widget(
                            item.branch_name,
                            item.service_name,
                            item.current_turn,
                            item.queue,
                            item.my_turn,
                          ),
                        );
                      })
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
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
  }
}
