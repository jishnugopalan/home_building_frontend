import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebuilding/interiorDesigner/myprofile.dart';
import 'package:homebuilding/services/workservice.dart';


class ViewWorkDetails extends StatefulWidget {
  const ViewWorkDetails({Key? key, required this.workid}) : super(key: key);
  final String workid;

  @override
  State<ViewWorkDetails> createState() => _ViewWorkDetailsState();
}

class _ViewWorkDetailsState extends State<ViewWorkDetails> {
  WorkService service=WorkService();
  late final Response res;
  late Map<String, dynamic> data={};
  getWorkDetails() async {
    try{
      res=await service.viewWorkById(widget.workid);
      setState(() {
        data=res.data;
      });
      print(data);

    }on DioError catch(e){

      showError("Error in fetching data", "Oops!");
    }
  }
  removeWork() async {
    try{
      final Response r=await service.removeWork(widget.workid);
      print(data);
      showError("Work removed successfully", "Work Removed");

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
                  if(title=="Work Removed"){
                   data.clear();

                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MyProfile(),
                    ),
                  );

                 // Navigator.of(context).pop();
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
    print(widget.workid);
    getWorkDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Details"),
      ),
      body:Container(
        child:ListView(
          children: [
            if(data.isEmpty)...[
              Container(
                child:  CircularProgressIndicator(),
              )
            ]else...[
             Container(
               padding: EdgeInsets.all(20),
               child:Text(data["work_name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
             ),
              Container(
                padding: EdgeInsets.all(20),
                child:Card(
                  child:Image.memory(
                    base64Decode(data['work_image'].split(',')[1]),
                    fit: BoxFit.cover,
                  ) ,
                )
              ),
              Container(
                padding: EdgeInsets.all(20),
                child:Text(data["work_description"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: (){
                    removeWork();
                  },
                  child: Text("Remove"),
                ),
              )

            ]
          ],
        ),
      )
    );
  }
}
