import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _email; 

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Make API call to reset password here
      // Display success or error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: ListView(
        children: [Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *
                            .02),
              Image(
                image: AssetImage('assets/forgotpassword.png'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height *
                            .02),              
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }else {
                          setState(() {
                            _email = value;
                          });
                        }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height *
                            .02),
              ElevatedButton(
                style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10)),
                      ),
                onPressed: _submitForm,
                child: Text('Reset Password', style: TextStyle(fontSize: 20), ),
              ),
            ],
          ),
        ),
      ),],
      )
    );
  }
}
