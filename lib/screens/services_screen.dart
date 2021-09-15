import 'package:flutter/material.dart';
import 'package:inline/widgets/buttonList_widget.dart';
import 'package:inline/widgets/typeoflist_widget.dart';
import '../widgets/appBar_widget.dart';

class Services_Screen extends StatefulWidget {
  @override
  _Services_ScreenState createState() => _Services_ScreenState();
}

class _Services_ScreenState extends State<Services_Screen> {
  final list = [
    {"title": "Vodafone", "image": "assets/images/ph2.png"},
    {"title": "orange", "image": "null"},
    {"title": "Etslate", "image": "null"},
    {"title": "Etslate", "image": "null"},
    {"title": "Etslate", "image": "null"},
    {"title": "Etslate", "image": "null"},
    {"title": "Etslate", "image": "null"},
    {"title": "Etslate", "image": "null"},
  ];

  final String path = "assets/images/ph2.png";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          appBar: appBar_Widget(),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //is there is photo or title put it other wise faks
                  Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: TypeOfList_widget("Vodafone", path),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  ...list.map((item) {
                    return ButtonList_Widget(
                        item["title"].toString(), item["image"].toString());
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
