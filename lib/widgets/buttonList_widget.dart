import 'package:flutter/material.dart';
import '../widgets/typeoflist_widget.dart';

class ButtonList_Widget extends StatelessWidget {
  final String buttonText;
  final String buttonImg;

  ButtonList_Widget(this.buttonText, this.buttonImg);

  bool isImg(String path) {
    if (buttonImg == "null") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final pad = isImg(buttonImg) ? 60.0 : 0.0;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: FlatButton(
        onPressed: null,
        child: Container(
          padding: EdgeInsets.only(right: pad),
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isImg(buttonImg))
                Container(
                  height: 50,
                  //width: 20,
                  width: 60,
                  child: Transform.scale(
                    scale: 0.6,
                    child: Image.asset(buttonImg),
                  ),
                ),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000000),
                ),
              )
            ],
          ),
        ),
        //textColor: Color(0xff000000),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff5A8D40),
            width: 6,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(78),
        ),
        minWidth: 250,
        height: 70,
      ),
    );
  }
}
