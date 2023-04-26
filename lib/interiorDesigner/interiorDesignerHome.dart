import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'interior_menu.dart';

class InteriorDesignerHome extends StatefulWidget {
  const InteriorDesignerHome({Key? key}) : super(key: key);

  @override
  _InteriorDesignerHomeState createState() => _InteriorDesignerHomeState();
}

class _InteriorDesignerHomeState extends State<InteriorDesignerHome> {
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
          drawer: InteriorMenu(),
          body: Center(
            child: Text('Welcome'),
          ),
        ));
  }
}
