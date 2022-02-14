import 'package:flutter/material.dart';
import 'package:inline/screens/provider_screen.dart';
import '../api/getServices_api.dart';
import '../screens/pay_screen.dart';
import '../modules/branch.dart';
import '../modules/service.dart';
import '../api/getProviders_api.dart';
import '../api/getBranches_api.dart';
import '../modules/provider.dart';
import '../modules/user_shared_Preferences.dart';
import '../widgets/buttonList_widget.dart';
import '../widgets/typeoflist_widget.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/main_drawer_widget.dart';
import 'package:location/location.dart';

class Services_Screen extends StatefulWidget {
  @override
  _Services_ScreenState createState() => _Services_ScreenState();
}

class _Services_ScreenState extends State<Services_Screen> {
  final List<dynamic> _allList = [
    "banking",
    "telecommunication",
    "clinics",
  ];


  List<dynamic> _foundList = [];

  void _navToProvider(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Provider_Screen();
        },
      ),
    );
  }

  /////////////////////////////////search filter/////////////
  @override
  initState() {
    // at the beginning, all users are shown
    _foundList = _allList;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allList;
    } else {
      for (int i = 0; i < _allList.length; i++) {
        if (_allList[i].toLowerCase().contains(enteredKeyword.toLowerCase())) {
          results.add(_allList[i]);
        }
      }
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundList = results;
    });
  }

  /////////////////////////////////search filter/////////////

  @override
  Widget build(BuildContext context) {
    print(_foundList);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          drawer: MainDrawer(),
          appBar: appBar_Widget(_runFilter),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //is there is photo or title put it other wise faks
                // Container(
                //   child:
                //       _index > 1 ? TypeOfList_widget("Vodafone", "null") : null,
                // ),
                SizedBox(
                  height: 50,
                ),

                Expanded(
                  child: _foundList.length > 0
                      ? ListView.builder(
                          itemCount: _foundList.length,
                          itemBuilder: (context, i) {
                            dynamic item = _foundList[i];
                            String name = "", photo = "null";
                            dynamic handler = () {};

                            name = item;
                            photo = "null";
                            handler = () => GetprovidersApi.getProviders(
                                  name,
                                  "https://inline.mrtechnawy.com/api/provider/all",
                                  context,
                                  _navToProvider,
                                );

                            return ButtonList_Widget(name, photo, handler);
                          })
                      : Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
