import 'package:flutter/material.dart';

class Button_Widget extends StatelessWidget {
  String buttonName;
  Function actionButton;
  Button_Widget(this.buttonName, this.actionButton);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () => actionButton(context),
      child: Text(
        buttonName,
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.headline6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(78),
      ),
      color: Color(0xffC4C4C4),
      minWidth: 185,
    );
  }
}
