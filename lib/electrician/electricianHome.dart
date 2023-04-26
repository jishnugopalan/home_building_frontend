import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            title: Text('Electrician Home'),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('Jishnu Gopal', style: TextStyle(fontSize: 25)),
                  accountEmail: Text('jishnu@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/profileAvatar.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushNamed(context, '/electricianHome');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.collections),
                  title: Text('Portfolio'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Text('Welcome to Interior Designer App!'),
          ),
        ));
  }
}
