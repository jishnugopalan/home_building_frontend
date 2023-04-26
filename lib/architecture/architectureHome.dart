import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('Gopika Venugopal', style: TextStyle(fontSize: 25)),
                  accountEmail: Text('tenddygopz@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/profileAvatar.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                     Navigator.pushNamed(context, '/architectureHome');
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
                  title: Text('Add Work'),
                  onTap: () {
                    Navigator.pushNamed(context, '/addworkarchi');
                  },
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
