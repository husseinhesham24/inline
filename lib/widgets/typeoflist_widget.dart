import 'package:flutter/material.dart';

class TypeOfList_widget extends StatelessWidget {
  final String imgPath;
  final String imgTitle;

  TypeOfList_widget(this.imgTitle, this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (imgPath != "null")
          Container(
            height: 100,
            //width: 20,
            width: 60,
            child: Transform.scale(
              scale: 0.6,
              child: imgPath!=null?(imgPath) as Widget:null,
            ),
          ),
        Text(
          imgTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff000000),
          ),
        )
      ],
    );
  }
}
