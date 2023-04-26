import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homebuilding/services/authservice.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final storage = FlutterSecureStorage();
  bool obscureText1 = true;
  RegistrationService service=RegistrationService();
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
  _Submit() async {
    if (_formKey.currentState!.validate()) {
      print("Email: $_email Password: $_password");
     var user=jsonEncode({
       "email":_email,
       "password":_password
     });
     try{
       final Response res=await service.loginUser(user);
       print(res);
       Map<String, String> allValues = await storage.readAll();
       String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
       String userid= json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
       print(userid);
       await storage.write(key: "userid", value: userid);
       if(res.data["user"]["usertype"]=="customer"){
         print("in");
         Navigator.pushNamedAndRemoveUntil(context, '/customerHome', (route) => false);


       }
       else if(res.data["user"]["usertype"]=="interior"){
         print("in");
         Navigator.pushNamedAndRemoveUntil(context, '/interiorHome', (route) => false);

       }
       else if(res.data["user"]["usertype"]=="architect"){
         Navigator.pushNamedAndRemoveUntil(context, '/architectureHome', (route) => false);

       }
       else if(res.data["user"]["usertype"]=="electrician"){
         Navigator.pushNamedAndRemoveUntil(context, '/electricianHome', (route) => false);

       }



     }on DioError catch(e){


       if (e.response != null) {
         print(e.response!.data);

         showError(e.response!.data["error"], "Login Failed");


       } else {
         // Something happened in setting up or sending the request that triggered an Error
         showError("Error occured,please try againlater","Oops");
       }
     }
    }


    // if (_email == "abhi@gmail.com" && _password == "#Abhi#1234") {
    //   Navigator.pushNamed(context, '/interiorHome');
    //   print("Login Success");
    // }
    // else if (_email == "abhi1@gmail.com" && _password == "#Abhi#1235") {
    //   Navigator.pushNamed(context, '/architectureHome');
    //   print("Login Success");
    // }
    // else if (_email == "abhi2@gmail.com" && _password == "#Abhi#1236") {
    //   Navigator.pushNamed(context, '/electricianHome');
    //   print("Login Success");
    // }
    // else if (_email == "abhi3@gmail.com" && _password == "#Abhi#1237") {
    //   Navigator.pushNamed(context, '/customerHome');
    //   print("Login Success");
    // }
    // else {
    //   print("Login Failed");
    // }
  }


  Future<void> checkAuthentication() async {
    try{
      Map<String, String> allValues = await storage.readAll();
      if(allValues["token"]!.isEmpty){
        print("token empty");
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
      }
      else{
        print("token is here");
        Map<String, String> allValues = await storage.readAll();
        String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
        String userid= json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
        this.getUser(userid);

      }

    }catch(e){

    }
  }
  Future<void> getUser(String userid) async {
    try{

      final Response? response=await service.getUser(userid);
      if(response?.data["usertype"]=="customer"){
        Navigator.pushNamedAndRemoveUntil(context, '/customerHome', (route) => false);


      }
      else if(response?.data["usertype"]=="interior"){
        Navigator.pushNamedAndRemoveUntil(context, '/interiorHome', (route) => false);

      }
      else if(response?.data["usertype"]=="architect"){
        Navigator.pushNamedAndRemoveUntil(context, '/architectureHome', (route) => false);

      }
      else if(response?.data["usertype"]=="electrician"){
        Navigator.pushNamedAndRemoveUntil(context, '/electricianHome', (route) => false);

      }


    }on DioError catch(e){
      if (e.response != null) {
        print(e.response!.data);

        showError("Login failed", "Please login again");


      } else {
        // Something happened in setting up or sending the request that triggered an Error
        showError("Error occured,please try againlater","Oops");
      }

    }


  }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();


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
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 170, 255),
                      ),
                    ),
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/login.png'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
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
                        }
                        else {
                          setState(() {
                            _email = value;
                          });
                        }  
                        return null;
                      },
                      // onSaved: (value) => _email = value,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
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
                      onPressed: _Submit,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You don\'t remember your password? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgotpassword');
                            },
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            .02), //SizedBox for Add space between Text Boxes
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You don\'t have account yet? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
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
