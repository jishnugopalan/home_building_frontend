import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ArchitechtMenu extends StatefulWidget {
  const ArchitechtMenu({Key? key}) : super(key: key);

  @override
  State<ArchitechtMenu> createState() => _ArchitechtMenuState();
}

class _ArchitechtMenuState extends State<ArchitechtMenu> {
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Architect Dashboard', style: TextStyle(fontSize: 25)),
              accountEmail: Text(''),
              currentAccountPicture: Icon(Icons.account_circle,color: Colors.white,size: 50,)
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/architectureHome');
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
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Quotations'),
            onTap: () {
              Navigator.pushNamed(context, '/viewquotationvendor');
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
