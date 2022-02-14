import 'package:flutter/material.dart';

import '../widgets/appBar_widget.dart';
import '../widgets/main_drawer_widget.dart';

class Reserve_Screen extends StatefulWidget {
  @override
  _Reserve_ScreenState createState() => _Reserve_ScreenState();
}

class _Reserve_ScreenState extends State<Reserve_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: appBar_Widget(() {}, true),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text("5"),
                ),
              ),
            ),
            title: Text(
              "Credit Agricole Bank",
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Deposit"),
              ],
            ),
            // ignore: deprecated_member_use
            trailing: Column(
              children: [
                Text("waiting queue: 6"),
                SizedBox(
                  height: 21,
                ),
                Text("current Turn: 6"),
              ],
            ),
            // ignore: deprecated_member_use
          ),
        ),
      ),
    );
  }
}
