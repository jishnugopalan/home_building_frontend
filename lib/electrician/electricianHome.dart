import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'electrician_menu.dart';

class ElectricianHome extends StatefulWidget {
  const ElectricianHome({Key? key}) : super(key: key);

  @override
  _ElectricianHomeState createState() => _ElectricianHomeState();
}

class _ElectricianHomeState extends State<ElectricianHome> {
  @override
  Widget build(BuildContext context) {
    // Set the system UI overlay style here
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // Sets the status bar color to blue
        statusBarBrightness: Brightness.dark, // Sets the status bar icons to be dark
        statusBarIconBrightness: Brightness.dark, // Sets the status bar icons to be dark
      ),
    );
    return WillPopScope(
        onWillPop: () async {
          //Navigator.pushNamedAndRemoveUntil(context, '', (route) => false);
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          drawer: ElecticianMenu(),
          body: Center(
            child: Text('Welcome'),
          ),
        ));
  }
}
