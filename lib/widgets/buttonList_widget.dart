import 'package:flutter/material.dart';
import '../screens/pay_screen.dart';
import '../widgets/typeoflist_widget.dart';

class ButtonList_Widget extends StatelessWidget {
  final String buttonText;
  final String buttonImg;
  final VoidCallback selectHandler;

  ButtonList_Widget(this.buttonText, this.buttonImg, this.selectHandler);

  bool isImg(String path) {
    if (buttonImg == "null") {
      return false;
    }
    return true;
  }

  // void navToPayPage(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return Pay_Screen();
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final pad = isImg(buttonImg) ? 60.0 : 0.0;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: selectHandler,
        child: Container(
          //padding: EdgeInsets.only(right: pad),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // if (isImg(buttonImg))
              //   Container(
              //     height: 50,
              //     //width: 20,
              //     width: 60,
              //     child: Transform.scale(
              //       scale: 0.6,
              //       child: Image.asset(buttonImg),
              //     ),
              //   ),
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
        minWidth: double.infinity,
        height: 70,
      ),
    );
  }
}
