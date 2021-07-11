
import 'question.dart';

class QuestionBank{
  List _qBank = <Question>[
    Question('Ab tak campus nhi dekha kya?', true),
    Question('Do you love memes?', true),
    Question('Do u lob online sem?', true),
    Question('Do u lob WnCC?', true),
    Question('Am I sad?', false),
    Question('Are you sad?', true),
    Question('Missing insti :( ?', true),
    Question('Mumbai se ho?', false),
    Question('Will you follow me on insta (rohanrkalbag) <3 ?', true),
    Question('Do you think I will <3 ?', true)
  ];
  String getQuestion(int qNo){
    return _qBank[qNo-1].questionText;
  }
  bool isCorrect(int qNo, bool ans){
    return (_qBank[qNo-1].answer == ans);
  }
  int getLength(){
    return _qBank.length;
  }

}

