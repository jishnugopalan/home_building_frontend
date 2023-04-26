import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/customer/customermenu.dart';
import 'package:homebuilding/interiorDesigner/viewcustomer.dart';
import 'package:homebuilding/services/workservice.dart';


class ViewConnections extends StatefulWidget {
  const ViewConnections({Key? key}) : super(key: key);

  @override
  State<ViewConnections> createState() => _ViewConnectionsState();
}

class _ViewConnectionsState extends State<ViewConnections> {
  final storage = const FlutterSecureStorage();
  WorkService service=WorkService();
  List<dynamic> data = [];
  getConnections() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    try{
      final Response res=await service.viewConnectionByVendor(userid!);
      print(res.data);
      final jsonData = res.data as List<dynamic>;
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
    getConnections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Connections"),
      ),

      body: ListView.builder(
          padding: EdgeInsets.all(10),

          itemCount: data.length,
          itemBuilder: (contex,index){
            return ListTile(
              title: Text(data[index]["user"]["name"]),
              leading: Icon(Icons.account_circle,size: 50,color: Colors.orange,),
              subtitle: Text(data[index]["status"]),
              tileColor: data[index]['status']=="request sent"?Colors.grey[200]:Colors.white10,
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewCustomerDetails(connectionid: data[index]["_id"],),
                  ),
                );
              },
            );


          }
      ),
    );
  }
}
