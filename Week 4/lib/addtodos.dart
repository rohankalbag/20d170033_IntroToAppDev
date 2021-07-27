import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EnterTodo extends StatefulWidget {
  EnterTodo({this.uid});
  final String uid;

  @override
  _EnterTodoState createState() => _EnterTodoState();
}

class _EnterTodoState extends State<EnterTodo> {
  final _todoKey = GlobalKey<FormState>();
  TextEditingController todoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text("Enter Details"),
          backgroundColor: Colors.purple,
        ),
        body: Form(
            key: _todoKey,
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,150,10,10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey[300]),
                          controller: todoController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey[300]),
                            labelText: "Enter Reminder Todo",
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
                              return 'Enter Reminder Todo';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,10,10,10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey[300]),
                          controller: dateController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey[300]),
                            labelText: "Enter Date in DD/MM/YYYY",
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
                            if(value.length == 10) {
                              if (value.isEmpty) {
                                return 'Enter Date';
                              } else if (!value.contains('/')) {
                                return 'Please enter in the valid format';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,10,10,10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey[300]),
                          controller: timeController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey[300]),
                            labelText: "Enter time in 24h format 00:00:00",
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
                              return 'Enter time';
                            } else if (value.length != 8 ) {
                              return 'Enter time in the correct format';
                            }
                            else if (!value.contains('/')){
                              return 'Enter time in the correct format';
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
                            onPressed: () async {
                                DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users").child(widget.uid);
                                dbRef.child("Todos List").push().set({
                                  "reminder" : todoController.text,
                                  "date": dateController.text,
                                  "time": timeController.text
                                }).catchError((e) => print(e)).then((value){
                                Navigator.pop(context);
                                });
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
        ),
      ),
    );
  }
}