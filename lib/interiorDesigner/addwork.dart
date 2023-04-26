import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/services/workservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InteriorDesignerAddWork extends StatefulWidget {
  @override
  _InteriorDesignerAddWorkState createState() => _InteriorDesignerAddWorkState();
}

class _InteriorDesignerAddWorkState extends State<InteriorDesignerAddWork> {
  final _formKey = GlobalKey<FormState>();

  WorkService service=WorkService();
  // Form fields
  String _title = '';
  String _description = '';
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final storage = const FlutterSecureStorage();

  _AddWork() async {
    Map<String, String> allValues = await storage.readAll();
    String? userid=allValues["userid"];
    List<String>? s=_image?.path.toString().split("/");
    final bytes=await File(_image!.path).readAsBytes();
    final base64=base64Encode(bytes);
    var pic="data:image/"+s![s.length-1].split(".")[1]+";base64,"+base64;
    print(pic);
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        _formKey.currentState!.save();
        print(_title);
        print(_description);
        print(_image!.path);
        var workdetails=jsonEncode({
          "user":userid,
          "work_name":_title,
          "work_description":_description,
          "work_image":pic
        });
        try{
          final Response res=await service.addWork(workdetails);
          print(res.data);
          Fluttertoast.showToast(
              msg: "Work uploaded successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushNamed(context, '/myprofile');
        }on DioError catch(e){
          Fluttertoast.showToast(
              msg: "Please upload an image of work",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.red,
              fontSize: 16.0);
        }

      }
    } else {
      Fluttertoast.showToast(
          msg: "Please upload an image of work",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Work'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Work Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Name connot have numbers or symbols';
                    } else {
                      setState(() {
                        _title = value;
                      });
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Name connot have numbers or symbols';
                      } else {
                        setState(() {
                          _description = value;
                        });
                      }
                      return null;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                ElevatedButton(
                    onPressed: () async {
                      final pickedImage =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _image = pickedImage;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo),
                        SizedBox(width: 10),
                        Text("Upload Image"),
                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                Container(

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _image != null
                      ? Image.file(File(_image!.path))
                      : Icon(Icons.add_photo_alternate),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                ElevatedButton(
                  onPressed: _AddWork,
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10)),
                  ),
                  child: Text(
                    'Add Work',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
