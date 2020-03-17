import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  final _questions = const [
    {
      'questionText': 'What\'s my favorite color?',
      'answers': ['Black', 'White', 'Red', 'Green', 'Blue', 'Yellow'],
      'rightAnswer': 'Yellow',
    },
    {
      'questionText': 'What\'s my favorite animal?',
      'answers': ['Elephant', 'Lion', 'Cat', 'Dog', 'Dolphin', 'Dinosaur'],
      'rightAnswer': 'Dinosaur',
    },
    {
      'questionText': 'What\'s my favorite alcohol?',
      'answers': ['Beer', 'Sider', 'Wine'],
      'rightAnswer': 'Sider',
    },
  ];

  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(String answer) {
    setState(() {
      if (answer == _questions[_questionIndex]['rightAnswer']) _totalScore++;
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Quizzz'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_totalScore, _resetQuiz),
    ));
  }
}
