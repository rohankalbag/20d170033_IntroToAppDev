
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
class Calc
{
  String myData = '0';
  double arg1 = 0;
  double arg2 = 0;
  double ans = 0;

  var arg1IsSelected = [false,false,false,false];
  void calcFunction(String data) {
    if (myData != '0') {
      switch (data) {
        case 'C':
          this.myData = '0';
          arg1IsSelected = [false,false,false,false];
          break;
        case '<<x':
          this.myData = this.myData.substring(0, this.myData.length - 1);
          break;
        case '/':
          if(!arg1IsSelected.contains(true)) {
            this.arg1 = double.parse(this.myData);
            this.myData = '0';
            arg1IsSelected[0] = true;
          }
          break;
        case '*':
          if(!arg1IsSelected.contains(true)) {
            this.arg1 = double.parse(this.myData);
            this.myData = '0';
            arg1IsSelected[1] = true;
          }
          break;
        case '+':
          if(!arg1IsSelected.contains(true)) {
            this.arg1 = double.parse(this.myData);
            this.myData = '0';
            arg1IsSelected[2] = true;
          }
          break;
        case '-':
          if(!arg1IsSelected.contains(true)) {
            this.arg1 = double.parse(this.myData);
            this.myData = '0';
            arg1IsSelected[3] = true;
          }
          break;
        case '9':
          this.myData = this.myData + '9';
          break;
        case '8':
          this.myData = this.myData + '8';
          break;
        case '7':
          this.myData = this.myData + '7';
          break;
        case '6':
          this.myData = this.myData + '6';
          break;
        case '5':
          this.myData = this.myData + '5';
          break;
        case '4':
          this.myData = this.myData + '4';
          break;
        case '3':
          this.myData = this.myData + '3';
          break;
        case '2':
          this.myData = this.myData + '2';
          break;
        case '1':
          this.myData = this.myData + '1';
          break;
        case '.':
          this.myData = this.myData + '.';
          break;
        case '0':
          this.myData = this.myData + '0';
          break;
        case '00':
          this.myData = this.myData + '00';
          break;
        case '=':
          if(arg1IsSelected.contains(true)) {
            this.arg2 = double.parse(this.myData);
            int a = arg1IsSelected.indexOf(true);
            switch(a){
              case 0:
                this.ans = arg1/arg2;
                break;
              case 1:
                this.ans = arg1*arg2;
                break;
              case 2:
                this.ans = arg1+arg2;
                break;
              case 3:
                this.ans = arg1-arg2;
                break;
            }
            this.myData = this.ans.toStringAsFixed(2);
            this.arg1IsSelected = [false,false,false,false];
          }
      }
    }
    else {
      switch (data) {
        case '9':
          this.myData = '9';
          break;
        case '8':
          this.myData = '8';
          break;
        case '7':
          this.myData = '7';
          break;
        case '6':
          this.myData = '6';
          break;
        case '5':
          this.myData = '5';
          break;
        case '4':
          this.myData = '4';
          break;
        case '3':
          this.myData = '3';
          break;
        case '2':
          this.myData = '2';
          break;
        case '1':
          this.myData = '1';
          break;
        case '.':
          this.myData = this.myData + '.';
          break;
      }
    }
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Calc calc = Calc();
  Widget calcButton(String data){
    return Container(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: (){
            setState(() {
              calc.calcFunction(data);
            });
        },
        child: Text(data,style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: Column(
         children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(calc.myData,style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 calcButton('C'),
                 calcButton('<<x'),
                 calcButton('/'),
                 calcButton('*'),
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 calcButton('9'),
                 calcButton('8'),
                 calcButton('7'),
                 calcButton('-'),
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 calcButton('6'),
                 calcButton('5'),
                 calcButton('4'),
                 calcButton('+'),
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                       calcButton('3'),
                       SizedBox(width: 23),
                       calcButton('2'),
                       SizedBox(width: 23),
                       calcButton('1'),
                     ]
                     ),
                     SizedBox(height: 15),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         calcButton('.'),
                         SizedBox(width: 23),
                         calcButton('0'),
                         SizedBox(width: 23),
                         calcButton('00'),
                       ],
                     )
                   ],
                 ),
                 Container(
                   height: 135,
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                     primary: Colors.red[900], // background
                     onPrimary: Colors.white, // foreground
                   ),
                     onPressed: (){
                       setState(() {
                         calc.calcFunction('=');
                       });
                     },
                     child: Text("=",style: TextStyle(
                         fontSize: 25,
                         fontWeight: FontWeight.bold
                     ),),
                   ),
                 )
               ],
             ),
           )
         ],
        )
        ),
      );
  }
}


