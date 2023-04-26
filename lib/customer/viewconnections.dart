import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/services/quotationservice.dart';

import '../services/workservice.dart';
import 'customermenu.dart';


class ViewConnectedVendors extends StatefulWidget {
  const ViewConnectedVendors({Key? key, required this.workerid, required this.status, required this.usertype}) : super(key: key);
  final String workerid;
  final String status;
  final String usertype;

  @override
  State<ViewConnectedVendors> createState() => _ViewConnectedVendorsState();
}

class _ViewConnectedVendorsState extends State<ViewConnectedVendors> {
  WorkService service=WorkService();
  QuotationService service2=QuotationService();
  late Map<String, dynamic> data={};
  List<dynamic> data2 = [];
  final storage = const FlutterSecureStorage();
  bool s=false;
  final _formKey = GlobalKey<FormState>();

  String _quotation="";
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

  sendQuotation() async {
    print(_quotation);
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    var quo=jsonEncode({

      "workerid":widget.workerid,
      "user":userid,
      "quotation":_quotation

    });
    try{
      final Response res=await service2.addQuotation(quo);
      print(res);
      showError("Quotation added successfully", "Quotation added");
    }on DioError catch(e){
      showError("Error in fetching details", "Oops!");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkerDetail();
    getWorkDetails();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Connections"),
      ),
      drawer: CustomerMenu(),
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
                        if(widget.status=="accepted")...[
                          Text(
                            data["user"]["phone"].toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),

                          Text(
                            data["user"]["email"],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'About Company',
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
                        if(widget.status=="accepted")...[
                          SizedBox(height: 20,),
                          Text("Contact Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          Text(data["company_email"]),
                          Text(data["company_phone"].toString()),
                          ElevatedButton(onPressed: (){
                            setState(() {
                              if(s==true)
                               s=false;
                              else
                                s=true;
                            });
                          }, child:Text("Sent Quotations"))
                          

                        ],
                        if(s==true)...[

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  'Type about the quotation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the quotation';
                                    }
                                    setState(() {
                                      _quotation = value;
                                    });
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _quotation = value!;
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {

                                     sendQuotation();
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            ),

                          )

                        ],


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
      ),
    );
  }
}
