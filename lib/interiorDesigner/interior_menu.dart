import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InteriorMenu extends StatefulWidget {
  const InteriorMenu({Key? key}) : super(key: key);

  @override
  State<InteriorMenu> createState() => _InteriorMenuState();
}

class _InteriorMenuState extends State<InteriorMenu> {
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Interior Dashboard', style: TextStyle(fontSize: 25)),
            accountEmail: Text(''),
            currentAccountPicture: Icon(Icons.account_circle,color: Colors.white,size: 50,)
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/interiorHome');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Profile'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/profile');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.collections),
            title: Text('Add Work'),
            onTap: () {
              Navigator.pushNamed(context, '/addworkint');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/myprofile');
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Connections'),
            onTap: () {
              Navigator.pushNamed(context, '/viewconnections');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/settings');
          //   },
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {


                await storage.delete(key: "token");
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);


            },
          ),
        ],
      ),
    );
  }
}
