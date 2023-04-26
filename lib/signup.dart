import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:homebuilding/services/authservice.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _house;
  String? _street;
  String? _district="Alappuzha";
  int? _pincode;
  int _selectedValue = 1;
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool _shouldShow = false;
  String company_name="",company_email="",company_phone="";
  String company_district="Alappuzha",company_place="",company_pincode="",company_description="",company_licenseno="";
  final List<String> items = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];
  XFile? _imageFile;
  RegistrationService service=RegistrationService();

  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }
  Future<void> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }
  _handleRadioValueChange(int value) {
    setState(() {
      _selectedValue = value;
      print(_selectedValue);
      if (_selectedValue == 4) {
        _shouldShow = true;
      }
    });
  }
  submitForm() async {
    String usertype="";
    if(_selectedValue==1 || _selectedValue==2 || _selectedValue==3){
      if(_selectedValue==1)
        usertype="interior";
      else if(_selectedValue==2)
        usertype="architect";
      else if(_selectedValue==3)
        usertype="electrician";
      List<String>? s=_imageFile?.path.toString().split("/");
      final bytes=await File(_imageFile!.path).readAsBytes();
      final base64=base64Encode(bytes);
      var pic="data:image/"+s![s.length-1].split(".")[1]+";base64,"+base64;
      print(pic);

      var user=jsonEncode({
        "name":_name,
        "email":_email,
        "phone":_phone,
        "usertype":usertype,
        "company_name":company_name,
        "company_email":company_email,
        "company_phone":company_phone,
        "company_district":company_district,
        "company_place":company_place,
        "company_pincode":company_pincode,
        "company_licenseno":company_licenseno,
        "pic":pic,
        "password":_password
      });
      print(user);
      try{
        final Response res=await service.registerUser(user);
        print(res);
        showError("Registration process completed", "Registration Successful");


      }on DioError catch(e){
        showError("Error occured,please try againlater","Oops");
      }
    }
    else{
      var user=jsonEncode({
        "name":_name,
        "email":_email,
        "phone":_phone,
        "usertype":"customer",
        "password":_password,
        "housename":_house,
        "place":_street,
        "district":_district,
        "pincode":_pincode
      });
      print(user);
      try{
        final Response res=await service.registerUser(user);
        print(res);
        showError("Registration process completed", "Registration Successful");


      }on DioError catch(e){
        showError("Error occured,please try againlater","Oops");
      }

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
                  if(title=="Registration Successful"){
                    Navigator.pushNamed(context, '/login');
                  }
                  else
                    Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .01,
                      bottom: MediaQuery.of(context).size.height * .02),
                  width: MediaQuery.of(context).size.height * .20,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255),
                        Colors.white
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 170, 255),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have Account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              RichText(
                text: TextSpan(
                  text: 'Welcome,\n',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Create your account here',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              //Sign up Form is below
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    //Name textfield
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Name connot have numbers or symbols';
                        } else {
                          setState(() {
                            _name = value;
                          });
                        }
                        return null;
                      },
                      //  onSaved: (value) => _name = value,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    //Email textfield
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter valid email id';
                        } else {
                          setState(() {
                            _email = value;
                          });
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    //Phone textfield
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^\+?[0-9]{10,12}$')
                            .hasMatch(value)) {
                          return 'Enter valid phone number';
                        } else {
                          setState(() {
                            _phone = value;
                          });
                        }
                        return null;
                      },
                      // onSaved: (value) => _phone = value,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    //UserType Container
                    Container(
                       // height: MediaQuery.of(context).size.height * .32,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .01,
                                  left: MediaQuery.of(context).size.height *
                                      .055),
                              child: Text(
                                'User Type',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 88, 88, 88),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            //Interior designer radio button
                            RadioListTile(
                              title: Text('Interior Designer',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 110, 110, 110),
                                  )),
                              value: 1,
                              groupValue: _selectedValue,
                              onChanged: ((value) {
                                setState(() {
                                  _selectedValue = value!;
                                  if (_selectedValue != 4) {
                                    _shouldShow = false;
                                  }
                                });
                              }),
                            ),
                            //Architecture radio button
                            RadioListTile(
                              title: Text('Architecture',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 110, 110, 110),
                                  )),
                              value: 2,
                              groupValue: _selectedValue,
                              onChanged: ((value) {
                                setState(() {
                                  _selectedValue = value!;
                                  if (_selectedValue != 4) {
                                    _shouldShow = false;
                                  }
                                });
                              }),
                            ),
                            //Astrologist radio button
                            RadioListTile(
                              title: Text('Electrician',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 110, 110, 110),
                                  )),
                              value: 3,
                              groupValue: _selectedValue,
                              onChanged: ((value) {
                                setState(() {
                                  _selectedValue = value!;
                                  if (_selectedValue != 4) {
                                    _shouldShow = false;
                                  }
                                });
                              }),
                            ),
                            //Customer radio button
                            RadioListTile(
                              title: Text('Customer',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 110, 110, 110),
                                  )),
                              value: 4,
                              groupValue: _selectedValue,
                              onChanged: ((value) {
                                setState(() {
                                  _selectedValue = value!;
                                  if (_selectedValue == 4) {
                                    _shouldShow = true;
                                  }
                                });
                              }),
                            ),
                          ],
                        )),

                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02),
                    //SizedBox for Add space between Text Boxes
                    //required fields only for customer which will be hidden for others
                    if(_selectedValue==1 ||_selectedValue==2 || _selectedValue==3 )...[
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Company name',
                            // labelStyle: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                            //hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                ))),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Company name is required";
                          }
                          setState(() {
                            company_name=value;
                          });
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Company Email',
                            // labelStyle: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                            //hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                ))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Company email is required";
                          }
                          setState(() {
                            company_email=value;
                          });
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Company Phone',
                            // labelStyle: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                            //hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                ))),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Company phone number is required";
                          }
                          else if(value.length>10 || value.length<10){
                            return "Company phone number is required";
                          }
                          setState(() {
                            company_phone=value;
                          });
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),



                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Company Place',
                            // labelStyle: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                            //hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                ))),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Company place is required";
                          }
                          setState(() {
                            company_place=value;
                          });
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.02,right:MediaQuery.of(context).size.width*.02,top: MediaQuery.of(context).size.height*.02),
                          child: InputDecorator(
                            decoration: InputDecoration(

                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),


                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select District',
                                        style: TextStyle(
                                          //fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                          //color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,

                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: company_district,
                                onChanged: (value) {
                                  // print(value);
                                  setState(() {
                                    company_district = value as String;
                                  });

                                },


                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                //iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                                buttonHeight: 50,
                                buttonWidth: 160,

                                buttonElevation: 2,
                                itemHeight: 40,
                                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 200,
                                dropdownPadding: null,
                                // dropdownDecoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(14),
                                //   color: Colors.redAccent,
                                // ),

                                scrollbarAlwaysShow: true,
                                offset: const Offset(-10, 0),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),


                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Company pin code',
                            // labelStyle: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                            //hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                ))),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Company pin code is required";
                          }
                          else if(value.length<6 || value.length>6){
                            return "Company pin code should have 6 numbers";
                          }
                          setState(() {
                            company_pincode=value;
                          });
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Company License Number',
                            // labelStyle: TextStyle(color: Color.fromARGB(255, 53, 87, 33)),
                            //hintText: "First Name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 87, 33),
                                ))),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Company license number is required";
                          }

                          setState(() {
                            company_licenseno=value;
                          });
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Select company Image/company Logo",
                                style: TextStyle(
                                    fontSize: 16),
                              ),
                            ),
                            Center(
                              child: _imageFile == null
                                  ? Text('No image selected ')
                                  : Image.file(File(_imageFile!.path),width: 360,height:240 ,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                GestureDetector(

                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.photo_camera_rounded,size: 35,),
                                  ),
                                  onTap: getImageFromCamera,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(

                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.image_outlined,size: 35,),
                                  ),
                                  onTap: getImageFromGallery,
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),





                    ],
                    Visibility(
                      visible: _shouldShow,
                      child: Column(
                        children: [
                          //House textfield  
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'House',
                              prefixIcon: Icon(Icons.house),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your House name';
                              } else if (!RegExp(r'^[a-zA-Z ]+$')
                                  .hasMatch(value)) {
                                return 'House name connot have numbers or symbols';
                              } else {
                                setState(() {
                                  _house = value;
                                });
                              }
                              return null;
                            },
                            //  onSaved: (value) => _name = value,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          //Street textfield    
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Street',
                              prefixIcon: Icon(Icons.streetview),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Street';
                              } else if (!RegExp(r'^[a-zA-Z ]+$')
                                  .hasMatch(value)) {
                                return 'Street connot have numbers or symbols';
                              } else {
                                setState(() {
                                  _street = value;
                                });
                              }
                              return null;
                            },
                            //  onSaved: (value) => _name = value,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          //District textfield      
                          Container(
                            //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.02,right:MediaQuery.of(context).size.width*.02,top: MediaQuery.of(context).size.height*.02),
                              child: InputDecorator(
                                decoration: InputDecoration(

                                  //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),


                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select District',
                                            style: TextStyle(
                                              //fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              //color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,

                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                        .toList(),
                                    value: _district,
                                    onChanged: (value) {
                                      // print(value);
                                      setState(() {
                                        _district = value as String;
                                      });

                                    },


                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    //iconEnabledColor: Colors.black,
                                    iconDisabledColor: Colors.grey,
                                    buttonHeight: 50,
                                    buttonWidth: 160,

                                    buttonElevation: 2,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                    dropdownMaxHeight: 200,
                                    dropdownWidth: 200,
                                    dropdownPadding: null,
                                    // dropdownDecoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(14),
                                    //   color: Colors.redAccent,
                                    // ),

                                    scrollbarAlwaysShow: true,
                                    offset: const Offset(-10, 0),
                                  ),
                                ),
                              )),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          //Pincode textfield  
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Pincode',
                              prefixIcon: Icon(Icons.pin),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Pin code';
                              } else if (!RegExp(r'^[1-9][0-9]{5}$')
                                  .hasMatch(value)) {
                                return 'Pin code connot have alphabets or symbols';
                              } else {
                                setState(() {
                                  _pincode =  int.parse(value);
                                });
                              }
                              return null;
                            },
                            //  onSaved: (value) => _name = value,
                          ),
                          SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02),
                    Divider(),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02),
                        ],
                      ),
                    ),
                    
                    //password textfields
                    TextFormField(
                      obscureText: obscureText1,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText1 =
                                  !obscureText1; // toggle the value of obscureText
                            });
                          },
                          icon: Icon(obscureText1
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(value)) {
                          return 'Password should have at least one uppercase letter, at least one lowercase letter at least one digit at least one special character and at least 8 characters.';
                        } else {
                          setState(() {
                            _password = value;
                          });
                        }
                        return null;
                      },
                      // onSaved: (value) => _password = value,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    //Confirm password textfields
                    TextFormField(
                      obscureText: obscureText2,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText2 =
                                  !obscureText2; // toggle the value of obscureText
                            });
                          },
                          icon: Icon(obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(value)) {
                          return 'Password should have at least one uppercase letter, at least one lowercase letter at least one digit at least one special character and at least 8 characters.';
                        } else if (value != _password) {
                          print("Password " + _password.toString());
                          print("Confirm Pass " + value);
                          return 'Passwords do not match';
                        } else {
                          setState(() {
                            _confirmPassword = value;
                          });
                        }
                        return null;
                      },
                      //  onSaved: (value) => _confirmPassword = value,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                         submitForm();
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
