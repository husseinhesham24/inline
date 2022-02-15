import 'package:flutter/material.dart';

class Card_Widget extends StatelessWidget {
  final String branch, service, waiting, current, turn;
  Card_Widget(
    this.branch,
    this.service,
    this.waiting,
    this.current,
    this.turn,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: FittedBox(
              child: Text("5"),
            ),
          ),
        ),
        title: Text(
          branch,
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(service),
          ],
        ),
        // ignore: deprecated_member_use
        trailing: Column(
          children: [
            Text("waiting queue: ${waiting}"),
            SizedBox(
              height: 2,
            ),
            Text("current Turn: ${current}"),
            SizedBox(
              height: 2,
            ),
            Text("Your Turn: ${turn}"),
          ],
        ),
        // ignore: deprecated_member_use
      ),
    );
  }
}
