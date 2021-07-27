import 'package:flutter/material.dart';
import 'package:mytodo/screens/signup.dart';
import 'package:mytodo/screens/login.dart';

class SignUp extends StatelessWidget {
  final String title = "Sign Up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text("Authentication"),
          backgroundColor: Colors.purple,
        ),
        body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
    Widget>[
    Padding(
    padding: EdgeInsets.fromLTRB(10,10,10,10),
    child: Text("Todo App",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
    fontFamily: 'Roboto', color: Colors.white)),
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold)),
    child: Text('Sign Up'),
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EmailSignUp()),
    );
    },
    )),
    Padding(
    padding: EdgeInsets.all(10.0),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 58, vertical: 10),
        textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold)),
    child: Text("Login"),
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EmailLogIn()),
    );
    }))
    ]),
    ));
  }
}