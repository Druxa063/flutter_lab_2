import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_lab_2/homePage.dart';
import 'package:flutter_lab_2/user.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user = new User(name: "user");
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),


          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 120.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Login:",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your login';
                      }
                      return null;
                    },
                    onChanged: (text) {
                        print("CHANGE!");
                        user.name = text;
                    },
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password:",
                           ),
                    onChanged: (text) {
                    },
                  ),
                  ButtonBar(
                    children: <Widget>[
                      // TODO: Add a beveled rectangular border to CANCEL (103)
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          _usernameController.clear();
                          _passwordController.clear();
                        },
                      ),
                      // TODO: Add an elevation to NEXT (103)
                      // TODO: Add a beveled rectangular border to NEXT (103)
                      RaisedButton(
                        child: Text('Login'),
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        user: user,
                                      )),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
