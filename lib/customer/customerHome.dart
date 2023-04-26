import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homebuilding/customer/customermenu.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    // Set the system UI overlay style here
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // Sets the status bar color to blue
        statusBarBrightness:
            Brightness.dark, // Sets the status bar icons to be dark
        statusBarIconBrightness:
            Brightness.dark, // Sets the status bar icons to be dark
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
              title: Text('Customer Home'),
            ),
            drawer: CustomerMenu(),
            body: ListView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
              children: [
                SizedBox(
                height: MediaQuery.of(context).size.height * .50, 
                child:GridView.count(
                  crossAxisCount: 2,// number of columns
                  shrinkWrap: true, 
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/interiorlist');
                      },
                      child: Card(
                        color: Colors.blue[50],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.design_services_outlined),
                            SizedBox(height: MediaQuery.of(context).size.height * .01),
                            Text('Interior Designer', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/architectlist');
                      },
                      child: Card(
                        color: Colors.blue[50],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.architecture),
                            SizedBox(height: MediaQuery.of(context).size.height * .01),
                            Text('Architecture', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                    // add more categories here
                    GestureDetector(
                      onTap: () {
                       Navigator.pushNamed(context, '/electricianlist');
                      },
                      child: Card(
                        color: Colors.blue[50],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.electrical_services_sharp),
                            SizedBox(height: MediaQuery.of(context).size.height * .01),
                            Text('Electrician', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ],
            )));
  }
}
