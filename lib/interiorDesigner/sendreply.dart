import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/services/quotationservice.dart';


class SendReply extends StatefulWidget {
  const SendReply({Key? key, required this.quotationid}) : super(key: key);
  final String quotationid;

  @override
  State<SendReply> createState() => _SendReplyState();
}

class _SendReplyState extends State<SendReply> {
  QuotationService service=QuotationService();
  late Map<String, dynamic> data={};
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  String _quotation="";
  getQuotations() async {
    try{
      final Response res=await service.viewQuotationById(widget.quotationid);
      print(res);
      setState(() {
        data=res.data;
      });
    }on DioError catch(e){
      print(e);
    }
  }
  sendQuotation() async {
    print(_quotation);
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    var quo=jsonEncode({

      "quotationid":widget.quotationid,
      "reply":_quotation

    });
    try{
      final Response res=await service.sendReply(quo);
      print(res);
      showError("Reply added successfully", "Reply added");
    }on DioError catch(e){
      showError("Error in fetching details", "Oops!");
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
    print(widget.quotationid);
    getQuotations();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sent Reply"),
      ),
      body: ListView(
        children: [
          if(data.isEmpty)...[
            Container(
              child:  CircularProgressIndicator(),
            )
          ]else...[
            Container(
              padding: EdgeInsets.all(20),
              child:Text(data["user"]["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child:Text(data["quotation"],style: TextStyle(fontSize: 20,),),
            ),
            if(data["reply"]==null)...[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Sent Reply',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the reply';
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

            ]else...[
              Container(
                padding: EdgeInsets.all(20),
                child:Text(data["reply"],style: TextStyle(fontSize: 20,),),
              ),
            ]
          ]
        ],
      ),
    );
  }
}
