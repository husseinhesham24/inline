import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final dynamic icon;
  final String iconName;

  DrawerItem(this.iconName, this.icon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
      ),
      title: Text(
        iconName,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {},
    );
  }
}
