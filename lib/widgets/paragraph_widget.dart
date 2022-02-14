import 'package:flutter/material.dart';

class Paragraph_Widget extends StatelessWidget {
  final String str1;
  final String str2;

  Paragraph_Widget(this.str1, this.str2);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            str1,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xff000000),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            str2,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}
