import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/customer/customermenu.dart';
import 'package:homebuilding/services/workservice.dart';

import '../interiorDesigner/viewworkdetails.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key, required this.workerid, required this.usertype}) : super(key: key);
  final String workerid,usertype;

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  WorkService service=WorkService();
  late Map<String, dynamic> data={};
  List<dynamic> data2 = [];
  final storage = const FlutterSecureStorage();
  getWorkerDetail() async {
    if(widget.usertype=="interior"){
      try{
        final Response res=await service.getInteriorById(widget.workerid);
        print(res);
        setState(() {
          data=res.data;
        });
      }on DioError catch(e){
        showError("Error in fetching details", "Oops!");
      }
    }
    else if(widget.usertype=="architect"){
      try{
        final Response res=await service.getArchitectById(widget.workerid);
        print(res);
        setState(() {
          data=res.data;
        });
      }on DioError catch(e){
        showError("Error in fetching details", "Oops!");
      }
    }
    else if(widget.usertype=="electrician"){
      try{
        final Response res=await service.getElectricianById(widget.workerid);
        print(res);
        setState(() {
          data=res.data;
        });
      }on DioError catch(e){
        showError("Error in fetching details", "Oops!");
      }
    }
  }

  getWorkDetails() async {

    try{
      final Response response2=await service.viewWorkByVendor(widget.workerid);
      final jsonData = response2.data as List<dynamic>;
      print(jsonData);
      setState(() {
        data2 = jsonData;
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

                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  sendRequest() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    var conn=jsonEncode({
      "user":userid,
      "worker":data["user"]["_id"]
    });
    print(conn);
    try{
      final Response res=await service.sendConnectionRequest(conn);
      print(res);
      showError("Connection request sent", "Connection Sent");
      
    }on DioError catch(e){

     if(e.response?.statusCode==400){
       showError("Connection request already sent", "Request Already Sent");
     }
     else{
       print(e.response?.data);
     }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.workerid+widget.usertype);
    getWorkerDetail();
    getWorkDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),

        body: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
            child: ListView(
                children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(data.isEmpty)...[
                    Container(
                      child:  CircularProgressIndicator(),
                    )
                  ]else...[
                    Icon(Icons.account_circle,size: 100,color: Colors.orange,),
                    Text(
                      data["user"]["name"],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data["user"]["usertype"].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'About me',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Text("Company name: "+data["company_name"]),
                    Text("Company District: "+data["company_district"]),
                    Text("Company Place: "+data["company_place"]),
                    Text("Company Pincode: "+data["company_pincode"].toString()),
                    ElevatedButton(onPressed: (){
                      sendRequest();

                    }, child: Text("Connect")),
                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Works',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    if(data2.isEmpty)...[
                      Text("No Workd Added")
                    ]else...[
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data2.length,
                    padding: EdgeInsets.all(10),

                    itemBuilder: (context,index){
                        return Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]

                          ),
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(data2[index]["work_name"],style: TextStyle(fontSize: 20),),
                                Image.memory(
                                base64Decode(data2[index]['work_image'].split(',')[1]),
                                fit: BoxFit.cover,
                                ),
                                Text(data2[index]["work_description"],style: TextStyle(fontSize: 18),)
                              ],
                          ),

                        );

                    })
    ]





                  ]

                  ]
              )


            ]


        )
    )
    );
  }
}
