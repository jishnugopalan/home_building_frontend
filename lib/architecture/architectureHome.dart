import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'architect_menu.dart';

class ArchitectureHome extends StatefulWidget {
  const ArchitectureHome({Key? key}) : super(key: key);

  @override
  _ArchitectureHomeState createState() => _ArchitectureHomeState();
}

class _ArchitectureHomeState extends State<ArchitectureHome> {
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
            title: Text('Architecture Home'),
          ),
          drawer: ArchitechtMenu(),
          body: Center(
            child: Text('Welcome'),
          ),
        ));
  }
}
