import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/interiorDesigner/sendreply.dart';
import 'package:homebuilding/services/quotationservice.dart';



class ViewQuotationVendor extends StatefulWidget {
  const ViewQuotationVendor({Key? key}) : super(key: key);

  @override
  State<ViewQuotationVendor> createState() => _ViewQuotationVendorState();
}

class _ViewQuotationVendorState extends State<ViewQuotationVendor> {
  final storage = const FlutterSecureStorage();
  QuotationService service=QuotationService();
  List<dynamic> data = [];
  getQuotations() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];

    try{
      final Response res=await service.viewQuotationByVendor(userid!);
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
                        Text("Quotation by "+data[index]["user"]["name"]
                            +"\n"+data[index]["quotation"]),
                        if(data[index]["reply"]!=null)...[
                          Container(
                            child: Text("Reply :"+data[index]["reply"]),
                          )
                        ]else...[
                          ElevatedButton(onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SendReply(quotationid: data[index]["_id"],),
                              ),
                            );
                          }, child: Text("Send Reply"))
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
