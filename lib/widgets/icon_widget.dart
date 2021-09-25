import 'package:flutter/material.dart';

class Icon_Widget extends StatelessWidget {
  String iconPath;
  Function iconAuth;
  Icon_Widget(this.iconPath, this.iconAuth);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: IconButton(
        icon: Image.asset(iconPath),
        onPressed: () => iconAuth(),
      ),
    );
  }
}
