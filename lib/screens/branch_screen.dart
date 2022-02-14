import 'package:flutter/material.dart';
import '../api/getServices_api.dart';
import '../screens/provider_screen.dart';
import '../modules/branch.dart';
import '../modules/provider.dart';
import '../modules/user_shared_Preferences.dart';
import '../screens/service_screen.dart';
import '../widgets/appBar_widget.dart';
import '../widgets/buttonList_widget.dart';
import '../widgets/main_drawer_widget.dart';

class Branch_Screen extends StatefulWidget {
  @override
  _Branch_ScreenState createState() => _Branch_ScreenState();
}

class _Branch_ScreenState extends State<Branch_Screen> {
  List<dynamic> _foundList = [];
  List<dynamic> _allList =
      Branch.decode(UserSharedPreferences.getString('branchData')!);

  void _navToService(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Service_Screen();
        },
      ),
    );
  }

  @override
  initState() {
    // at the beginning, all users are shown
    _foundList = _allList;
    super.initState();
  }

  /////////////////////////////////search filter/////////////

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allList;
    } else {
      for (int i = 0; i < _allList.length; i++) {
        if (_allList[i]
            .name
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
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

  void navToBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    print(_foundList);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: appBar_Widget(_runFilter, false),
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
                        print("service loool");
                        print(item.name);
                        name = item.name;
                        photo = "null";
                        //but the user lan and lon
                        handler = () {
                          GetServicesApi.getServices(
                            item.id,
                            "https://inline.mrtechnawy.com/api/branch/details",
                            context,
                            _navToService,
                          );
                        };
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => navToBack(context),
              icon: Icon(Icons.arrow_back_ios_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
