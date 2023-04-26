import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/interiorDesigner/viewworkdetails.dart';
import 'package:homebuilding/services/authservice.dart';
import 'package:homebuilding/services/workservice.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final storage = const FlutterSecureStorage();
  RegistrationService service1=RegistrationService();
  WorkService service2=WorkService();
  String name="";
  List<dynamic> data = [];
  getWorkerDetails() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    try{
      final Response response1=await service1.getUser(userid!);
      setState(() {
        name=response1.data["name"];
      });
      print(response1);
    }on DioError catch(e){
      showError("Error in fetching data", "Oops!");
    }
  }
  getWorkDetails() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    try{
      final Response response2=await service2.viewWorkByVendor(userid!);
      final jsonData = response2.data as List<dynamic>;
      print(jsonData);
      setState(() {
        data = jsonData;
      });
    }on DioError catch(e){
      showError("Error in fetching data", "Oops!");
    }

  }
  showError(String content,String title){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if(title=="Registration Successful"){
                    Navigator.pushNamed(context, '/login');
                  }
                  else
                    Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkerDetails();
    getWorkDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: ListView(

        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 100,
              child: Row(
                children: [
                  Icon(Icons.account_circle,color: Colors.orange,size: 50,),
                  Text(name,style: TextStyle(fontSize: 20,color: Colors.blueAccent),)
                ],
              ),
            ),
          ),
          Container(
            child: Text("Works",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              padding: EdgeInsets.all(10),
              
              itemBuilder: (context,index){
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]

                  ),
                  child: ListTile(
                    
                    title: Text(data[index]["work_name"]),
                    leading: Image.memory(
                      base64Decode(data[index]['work_image'].split(',')[1]),
                      fit: BoxFit.cover,
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewWorkDetails(workid: data[index]["_id"],),
                        ),
                      );
                    },


                  ),
                );

          })

        ],
      ),
    );
  }
}
