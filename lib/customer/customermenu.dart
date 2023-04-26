import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerMenu extends StatefulWidget {
  const CustomerMenu({Key? key}) : super(key: key);

  @override
  State<CustomerMenu> createState() => _CustomerMenuState();
}

class _CustomerMenuState extends State<CustomerMenu> {
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Customer Dashboard', style: TextStyle(fontSize: 25)),
              accountEmail: Text(''),
              currentAccountPicture: Icon(Icons.account_circle,color: Colors.white,size: 50,)
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/customerHome');
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('My Connections'),
            onTap: () {
              Navigator.pushNamed(context, '/myconnections');
            },
          ),
          ListTile(
            leading: Icon(Icons.note_add_outlined),
            title: Text('My Quotations'),
            onTap: () {
              Navigator.pushNamed(context, '/viewquotationcustomer');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Profile'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/profile');
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
