import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mytodo/home.dart';

class EmailSignUp extends StatefulWidget {
  const EmailSignUp({Key key}) : super(key: key);

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user.uid).set({
        "email": emailController.text,
        "name": nameController.text
      }).then((res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text("Authentication"),
          backgroundColor: Colors.purple,
        ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10,150,10,10),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey[300]),
                    controller: nameController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      labelText: "Enter Username",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                            width: 2.0,
                          )
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Username';
                      }
                      return null;
                    },
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10,10,10,10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[300]),
                      controller: emailController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey[300]),
                        labelText: "Enter Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: 2.0,
                            )
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10,10,10,10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[300]),
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey[300]),
                        labelText: "Enter Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: 2.0,
                            )
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            registerToFb();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        child: Text('Submit'),
                      ),
                    ],
                  )
              ]
              )
          )
      )
    );
  }
}
