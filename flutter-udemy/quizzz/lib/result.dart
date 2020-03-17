import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    return 'You\'re right in $resultScore cases';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              resultPhrase,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.all(30),
          ),
          FlatButton(
            child: Text('Restart quiz!'),
            textColor: Colors.blue,
            onPressed: resetHandler,
          ),
        ],
    ));
  }
}
