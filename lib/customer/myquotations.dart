import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/services/quotationservice.dart';

import 'customermenu.dart';


class ViewQuotationsCustomer extends StatefulWidget {
  const ViewQuotationsCustomer({Key? key}) : super(key: key);

  @override
  State<ViewQuotationsCustomer> createState() => _ViewQuotationsCustomerState();
}

class _ViewQuotationsCustomerState extends State<ViewQuotationsCustomer> {
  final storage = const FlutterSecureStorage();
  QuotationService service=QuotationService();
  List<dynamic> data = [];
  getQuotations() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];

    try{
      final Response res=await service.viewQuotationsByCustomer(userid!);
      print(res);
      final jsonData = res.data as List<dynamic>;
      print(jsonData);
      setState(() {
        data = jsonData;
      });
    }on DioError catch(e){
      print(e);
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuotations();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quotations"),
      ),
      drawer: CustomerMenu(),
      body: ListView(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,

              itemBuilder: (context,index){
                if(data.length!=0){
                  return Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Quotation to "+data[index]["worker"][0]["name"]+" "+data[index]["worker"][0]["usertype"]
                        +"\n"+data[index]["quotation"]),
                        if(data[index]["reply"]!=null)...[
                          Container(
                            child: Text(data[index]["reply"]),
                          )
                        ]else...[
                          Text("Not replied",style: TextStyle(color: Colors.redAccent),)
                        ]

                      ],
                    ),
                  );
                }
                else{
                  return Text("No Quotations added");
                }


          })
        ],
      ),
    );
  }
}
