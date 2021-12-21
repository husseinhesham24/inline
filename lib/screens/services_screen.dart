import 'package:flutter/material.dart';
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
    [
      "banking",
      "telecommunication",
      "clinics",
    ]
  ];

  var _index = 0;
  String _title = "";

  List<dynamic> _foundList = [];

  void _setProvidersList() {
    setState(() {
      _allList.add(
          Provider.decode(UserSharedPreferences.getString('providerData')!));
      print("setState _allList");
      print(_allList);
      _index = _index + 1;
      _foundList = _allList[_index];
    });
  }

  void _setBranchesList() {
    setState(() {
      _allList
          .add(Branch.decode(UserSharedPreferences.getString('branchData')!));
      _index = _index + 1;
      _foundList = _allList[_index];
    });
  }

  void _setServicesList() {
    setState(() {
      _allList
          .add(Service.decode(UserSharedPreferences.getString('serviceData')!));
      _index = _index + 1;
      _foundList = _allList[_index];
    });
  }

  void navToPayPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Pay_Screen();
        },
      ),
    );
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
      if (_index == 0) {
        for (int i = 0; i < _allList[_index].length; i++) {
          if (_allList[_index][i]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase())) {
            results.add(_allList[_index][i]);
          }
        }
      } else {
        for (int i = 0; i < _allList[_index].length; i++) {
          if (_allList[_index][i]
              .name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase())) {
            results.add(_allList[_index][i]);
          }
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

  void navToBack() {
    setState(() {
      _index = _index - 1;
      _allList.removeLast();
      _foundList = _allList[_index];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("founded");
    print(_index);
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
                Container(
                  child:
                      _index > 1 ? TypeOfList_widget("Vodafone", "null") : null,
                ),
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
                            if (_index == 0) {
                              name = item;
                              photo = "null";
                              handler = () => GetprovidersApi.getProviders(
                                    name,
                                    "https://inline.mrtechnawy.com/api/provider/all",
                                    context,
                                    _setProvidersList,
                                  );
                            } else if (_index == 1) {
                              // print(item);
                              // print(item.name);
                              // print(item.id);
                              // print(item.photo);
                              name = item.name;
                              photo = "null";
                              //but the user lan and lon
                              handler = () async {
                                Location location = new Location();
                                LocationData locationData =
                                    await location.getLocation();
                                GetBranchesApi.getBranches(
                                  item.id,
                                  "https://inline.mrtechnawy.com/api/provider/details",
                                  locationData.latitude ?? 0.0,
                                  locationData.longitude ?? 0.0,
                                  context,
                                  _setBranchesList,
                                );
                              };
                            } else if (_index == 2) {
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
                                  _setServicesList,
                                );
                              };
                            }
                            
                            
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
          bottomNavigationBar: _index == 0
              ? null
              : BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: navToBack,
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
