import 'package:flutter/material.dart';
import 'package:homebuilding/signup.dart';
import 'package:homebuilding/login.dart';
import 'package:homebuilding/forgotpassword.dart';
import 'package:homebuilding/interiorDesigner/interiorDesignerHome.dart';
import 'package:homebuilding/interiorDesigner/addwork.dart';
import 'package:homebuilding/architecture/architectureHome.dart';
import 'package:homebuilding/architecture/addwork.dart';
import 'package:homebuilding/electrician/electricianHome.dart';
import 'package:homebuilding/commonwindows/settings.dart';
import 'package:homebuilding/commonwindows/profile.dart';
import 'package:homebuilding/commonwindows/chatbox.dart';
import 'package:homebuilding/customer/customerHome.dart';
import 'package:homebuilding/customer/InteriorDesignerList.dart';
import 'package:homebuilding/customer/architectList.dart';
import 'package:homebuilding/customer/electricianList.dart';
import 'package:homebuilding/customer/viewProfile.dart';

import 'customer/myconnections.dart';
import 'interiorDesigner/myprofile.dart';
import 'interiorDesigner/viewconnections.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Building',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  LoginScreen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        '/interiorHome': (context) => InteriorDesignerHome(),
        '/architectureHome': (context) => ArchitectureHome(),
        '/electricianHome': (context) => ElectricianHome(),
        '/customerHome': (context) => CustomerHome(),
        '/settings': (context) => SettingsScreen(),
        '/myprofile': (context) => MyProfile(),
        '/addworkint': (context) => InteriorDesignerAddWork(),
        '/addworkarchi': (context) => ArchitectureAddWork(),
        '/interiorlist': (context) => InteriorProfileList(),
        '/architectlist': (context) => ArchitectProfileList(),
        '/electricianlist': (context) => ElectricianProfileList(),
        '/chatwindow': (context) => ChatScreen(),
        '/myconnections':(context)=>MyConnections(),
        '/viewconnections':(context)=>ViewConnections()

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
