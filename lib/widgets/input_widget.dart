import 'package:flutter/material.dart';

class Input_Widget extends StatelessWidget {
  String inputName;
  Input_Widget(this.inputName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 60),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 100,
              child: Text(
                inputName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              width: 185,
              height: 50,
              child: TextField(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                  fillColor: Color(0xffEEEAEA),
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
