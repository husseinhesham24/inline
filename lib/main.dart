import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../modules/user_shared_Preferences.dart';
import './screens/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreferences.init();

  Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xff5A8D40),
        statusBarColor: Color(0xff5A8D40),
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Inline',
      theme: ThemeData(
        primaryColor: Color(0xff5A8D40),
        backgroundColor: Color(0xfff7f7f7),
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              headline6: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
            ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
