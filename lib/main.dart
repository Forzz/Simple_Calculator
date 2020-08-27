import 'package:flutter/material.dart';

import 'widgets/calcButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _buttonChars = [
    ' ',
    ' ',
    ' ',
    '+',
    '1',
    '2',
    '3',
    '-',
    '4',
    '5',
    '6',
    '×',
    '7',
    '8',
    '9',
    '÷',
    'C',
    '0',
    '.',
    '=',
  ];

  isArithmeticOperator(String input) {
    if (input == '+' ||
        input == '-' ||
        input == '×' ||
        input == '÷' ||
        input == '=' ||
        input == 'C') {
      return true;
    } else {
      return false;
    }
  }

  String _result = '';

  _changeResultView(String button) {
    setState(() {
      if (!isArithmeticOperator(button)) {
        _result += button;
      } else if (button == 'C') {
        _result = '';
      } else {
        _result += ' $button ';
      }
    });
  }

  String _calculateResult(String result) {
    List<String> temp;
    double finalResult = 0;
    temp = result.split(' ');
    double firstNum = double.parse(temp[0]);
    double secondNum = double.parse(temp[2]);
    switch (temp[1]) {
      case '+':
        finalResult = firstNum + secondNum;
        break;
      case '-':
        finalResult = firstNum - secondNum;
        break;
      case '×':
        finalResult = firstNum * secondNum;
        break;
      case '÷':
        finalResult = firstNum / secondNum;
        break;
    }
    setState(() {
      _result = finalResult.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3ae),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffedd382),
                  border: Border.all(color: Color(0xffedd382)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                width: double.infinity,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    _result,
                    style: TextStyle(
                      fontSize: 50,
                      color: Color(0xffd3894b),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(35),
                child: GridView.builder(
                  itemCount: _buttonChars.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 27,
                    crossAxisSpacing: 23,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (_buttonChars[index] == '=') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(0xfffc9e4f),
                        Colors.white,
                        () => _calculateResult(_result),
                      );
                    } else {
                      return CalcButton(
                        _buttonChars[index],
                        Color(0xfffc9e4f),
                        Colors.white,
                        () => _changeResultView(_buttonChars[index]),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
