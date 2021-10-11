import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inline/modules/branch.dart';
import '../api/getProviders_api.dart';
import '../api/getBranches_api.dart';
import '../modules/provider.dart';
import '../modules/user_shared_Preferences.dart';
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
  final List<dynamic> _allList = [
    [
      "banking",
      "telecommunication",
      "clinics",
    ]
  ];

  var _index = 0;
  String _title = "";

  List<dynamic> _foundList = [];

  void getProvidersList(BuildContext ctx, String target) {
    GetprovidersApi.getProviders(
      target,
      "https://inline.mrtechnawy.com/api/provider/all",
      ctx,
    );

    setState(() {
      _allList.add(
          Provider.decode(UserSharedPreferences.getString('providerData')!));
      _index = _index + 1;
    });
  }

  void getBranchesList(BuildContext ctx, int id, double lan, double lon) {
    GetBranchesApi.getBranches(
      id,
      "https://inline.mrtechnawy.com/api/provider/all",
      lan,
      lon,
      ctx,
    );

    setState(() {
      _allList
          .add(Branch.decode(UserSharedPreferences.getString('branchData')!));
      _index = _index + 1;
    });
  }

  /////////////////////////////////search filter/////////////
  @override
  initState() {
    // at the beginning, all users are shown
    _foundList = _allList[_index];
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allList[_index];
    } else {
      results = _allList[_index]
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

  /////////////////////////////////search filter/////////////

  void navToBack() {
    setState(() {
      _index = _index - 1;
      _allList.removeLast();
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
                    child:
                        _index > 0 ? TypeOfList_widget("Vodafone", path) : null,
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
                    String name, photo;
                    Function handler;
                    return ButtonList_Widget(
                      item.name,
                      item.photo,
                      () => getProvidersList(context, item.name),
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
                  onPressed: _index == 0 ? null : navToBack,
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
