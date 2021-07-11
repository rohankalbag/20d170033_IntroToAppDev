import 'package:flutter/material.dart';
import 'bank.dart';

QuestionBank myBank = QuestionBank();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List <Widget> statusHolder = [
    Icon(Icons.arrow_forward),
  ];
  void updateCorrect(){
    statusHolder.add(
      Icon(Icons.check, color: Colors.green,)
    );
  }
  void updateWrong(){
    statusHolder.add(
        Icon(Icons.close, color: Colors.red,)
    );
  }
  bool flag = true;
  int noQuestions = myBank.getLength();
  int currentQuestion = 1;
  bool choice = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Insti Quiz"),
              centerTitle: true,
              backgroundColor: Colors.grey[800],
            ),
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 120, 30, 0),
                  child: Container(
                    height: 150,
                    child: Text(
                      myBank.getQuestion(currentQuestion),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 200, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,10),
                          child: SizedBox(
                            width: 500,
                            height: 70,// means 100%, you can change this to 0.8 (80%)
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.green)),
                              onPressed: (){
                                choice = true;
                                if(flag) {
                                  if (myBank.isCorrect(
                                      currentQuestion, choice)) {
                                    setState(() {
                                      if (currentQuestion <= noQuestions-1) {
                                        currentQuestion += 1;
                                        updateCorrect();
                                      }
                                      else if (currentQuestion == noQuestions) {
                                        updateCorrect();
                                        flag = false;
                                      }
                                    }
                                    );
                                  }
                                  else {
                                    setState(() {
                                      if (currentQuestion <= noQuestions-1) {
                                        currentQuestion += 1;
                                        updateWrong();
                                      }
                                      else if (currentQuestion == noQuestions) {
                                        updateWrong();
                                        flag = false;
                                      }
                                    }
                                    );
                                  }
                                }
                              },
                              child: Text('True', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,10),
                          child: SizedBox(
                            width: 500,
                            height: 70,// means 100%, you can change this to 0.8 (80%)
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red)),
                              onPressed: (){
                                choice = false;
                                if(flag) {
                                  if (myBank.isCorrect(
                                      currentQuestion, choice)) {
                                    setState(() {
                                      if (currentQuestion <= noQuestions-1) {
                                        currentQuestion += 1;
                                        updateCorrect();
                                      }
                                      else if (currentQuestion == noQuestions) {
                                        updateCorrect();
                                        flag = false;
                                      }
                                    }
                                    );
                                  }
                                  else {
                                    setState(() {
                                      if (currentQuestion <= noQuestions-1) {
                                        currentQuestion += 1;
                                        updateWrong();
                                      }
                                      else if (currentQuestion == noQuestions) {
                                        updateWrong();
                                        flag = false;
                                      }
                                    }
                                    );
                                  }
                                }
                              },
                              child: Text('False', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: statusHolder,
                        )
                      ],
                    )
                  ),
              ],
            ),
        ),
    );
  }
}
