import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void answerQuestion() {
      print('Answer chosen!');
    }

    var questions = [
      'What\'s your favorite color',
      'What\'s your favorite animal',
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quizzz'),
        ),
        body: Column(
          children: <Widget>[
            Text('The question!'),
            RaisedButton(child: Text('Answer 1'), onPressed: answerQuestion,),
            RaisedButton(child: Text('Answer 2'), onPressed: answerQuestion,),
            RaisedButton(child: Text('Answer 3'), onPressed: answerQuestion,),
          ],
        ),
      )
    );
  }
}
