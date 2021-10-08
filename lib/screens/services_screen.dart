import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inline/modules/user_shared_Preferences.dart';
import '../modules/user.dart';
import '../widgets/buttonList_widget.dart';
import '../widgets/typeoflist_widget.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/main_drawer_widget.dart';

class Services_Screen extends StatefulWidget {

  @override
  _Services_ScreenState createState() => _Services_ScreenState();
}

class _Services_ScreenState extends State<Services_Screen> {
  final List<Map<String, dynamic>> _allList = [
    {"title": "Vodafone", "image": "assets/images/ph2.png"},
    {"title": "orange", "image": "null"},
    {"title": "Etslate", "image": "null"},
  ];
  
  List<Map<String, dynamic>> _foundList = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundList = _allList;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allList;
    } else {
      results = _allList
          .where((company) => company["title"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundList = results;
    });
  }

  final String path = "assets/images/ph2.png";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          drawer: MainDrawer(),
          appBar: appBar_Widget(_runFilter),
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

                  // Expanded(
                  //   child: _foundList.length > 0
                  //       ? ListView.builder(
                  //           itemCount: _foundList.length,
                  //           itemBuilder: (context, index) => ButtonList_Widget(
                  //             _foundList[index]["title"].toString(),
                  //             _foundList[index]["image"].toString(),
                  //           ),
                  //         )
                  //       : Text(
                  //           'No results found',
                  //           style: TextStyle(fontSize: 24),
                  //         ),
                  // ),
                  ..._foundList.map((item) {
                    return ButtonList_Widget(
                      item["title"].toString(),
                      item["image"].toString(),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.arrow_back_ios_sharp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



