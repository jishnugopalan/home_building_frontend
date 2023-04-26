import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  String _name = "Abishek Ambareesh";
  String _email = "abhi@gmail.com";
  String _profileImageUrl = "assets/profileAvatar.png" ;
  // const ProfileScreen({
  //   required this.name,
  //   required this.email,
  //   required this.profileImageUrl,
  // });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Builder(
          builder: (BuildContext context) {
            return ListView(
                children: [
                  SizedBox(
                    height: 250,
                    //      width: 300,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 60),
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 15, bottom: 15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(600),
                                bottomRight: Radius.circular(600)),
                            color: Color.fromARGB(255, 165, 194, 224),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 60),
                          padding: const EdgeInsets.all(20),
                          child: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            child: SizedBox(
                              height: 140,
                              width: 140,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/profileAvatar.png"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 0),
                        child: Card(
                            shadowColor: Colors.blueAccent[400],
                            elevation: 6,
                            shape: const CircleBorder(),
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.blue,
                              ),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Card(
                          shadowColor: Colors.blueAccent[400],
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            height: 55,
                            width: 250,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 5),
                                  child: const Text('Name',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 5),
                                    child: const Text(
                                      "Sugunan",
                                      style: TextStyle(fontSize: 19),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 0),
                        child: Card(
                            shadowColor: Colors.blueAccent[400],
                            elevation: 6,
                            shape: const CircleBorder(),
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                              ),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Card(
                          shadowColor: Colors.blueAccent[400],
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            height: 55,
                            width: 250,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 5),
                                  child: const Text('Email',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 5),
                                    child: const Text(
                                      "sugunan@gmail.com",
                                      style: TextStyle(fontSize: 19),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 0),
                        child: Card(
                            shadowColor: Colors.blueAccent[400],
                            elevation: 6,
                            shape: const CircleBorder(),
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.phone_android_outlined,
                                color: Colors.blue,
                              ),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Card(
                          shadowColor: Colors.blueAccent[400],
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            height: 55,
                            width: 250,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 5),
                                  child: const Text('Phone',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(left: 5),
                                    child: const Text(
                                      "9867367450",
                                      style: TextStyle(fontSize: 19),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                ],
              );
          },
        ));
  }
}
