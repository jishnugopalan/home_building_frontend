import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebuilding/services/authservice.dart';
import 'package:homebuilding/services/workservice.dart';
import 'package:intl/intl.dart';


class ViewCustomerDetails extends StatefulWidget {
  const ViewCustomerDetails({Key? key, required this.connectionid,}) : super(key: key);
  final String connectionid;

  @override
  State<ViewCustomerDetails> createState() => _ViewCustomerDetailsState();
}

class _ViewCustomerDetailsState extends State<ViewCustomerDetails> {
WorkService service=WorkService();
late Map<String, dynamic> data={};
String d="";
  getCustomerDetails() async {
   try{
     final Response res=await service.viewConnectionById(widget.connectionid);
     print(res);
     setState(() {
       data=res.data;
     });
     DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(data['timestamp']) * 1000);
     String formattedDate = DateFormat.yMd().add_Hms().add_jm().format(dateTime);
     print(formattedDate);
     setState(() {
       d=formattedDate;
     });

   }on DioError catch(e){
     print(e);
   }
  }
  updateConnection() async {
    try{
      final Response res=await service.updateConnection(widget.connectionid);
      print(res);
      // setState(() {
      //   data["status"]="accept";
      // });
      showError("Connection accepted successfully", "Connection Successfull");

    }on DioError catch(e){
      showError("Error in connection", "Oops!");
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.connectionid);
    getCustomerDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connections"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          if(data.length!=0)...[
            Container(
                child: ListTile(
                  leading: Icon(Icons.account_circle,size: 50,color: Colors.orange,),
                  title: Text(data["user"]["name"],style: TextStyle(fontSize: 20),),
                  subtitle:Text(d) ,
                )
            ),
            if(data["status"]=="request sent")...[
              Text("Request not accepted",style: TextStyle(color: Colors.redAccent),),
              Container(
                child: ElevatedButton(onPressed: (){
                  updateConnection();
                }, child: Text("Accept")),
              )
            ]else...[
              Text(data["user"]["email"]),
              Text(data["user"]["phone"].toString())

            ]
          ]else...[
            Container(
              child: CircularProgressIndicator(),
            )
          ]
        ],
      ),
    );
  }
}
