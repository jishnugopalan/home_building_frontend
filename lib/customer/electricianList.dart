import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebuilding/customer/viewProfile.dart';
import 'package:homebuilding/services/workservice.dart';

class ElectricianProfileList extends StatefulWidget {
  @override
  _ElectricianProfileListState createState() => _ElectricianProfileListState();
}

class _ElectricianProfileListState extends State<ElectricianProfileList> {
  WorkService service=WorkService();
  List<dynamic> data = [];
  getAllInteriorDesigners() async {
    try{
      final Response res=await service.getAllElectrician();
      print(res);
      final jsonData = res.data as List<dynamic>;
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
    getAllInteriorDesigners();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interior Designer Profiles')),
      body: ListView.builder(
        itemCount: data.length,
        padding: EdgeInsets.all(10),

        itemBuilder: (BuildContext context, int index) {

          if(data.isEmpty){
            return CircularProgressIndicator();
          }
          else{
            return ListTile(


              title: Text(data[index]["user"]["name"] ?? "ggg",style: TextStyle(fontWeight: FontWeight.w600,fontSize:20),),
              leading: Icon(Icons.account_circle,size: 50,color: Colors.orange,),
              tileColor: Colors.grey[200],
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewProfile(workerid: data[index]["user"]["_id"],usertype: data[index]["user"]["usertype"],),
                  ),
                );
              },

            );
          }
        },
      ),
    );
  }
}
