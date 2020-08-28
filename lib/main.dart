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
    '←',
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
    '='
  ];

  bool isOperator(String input) {
    List<String> operators = ['+', '-', '×', '÷', '=', 'C'];
    return operators.contains(input);
  }

  String _result = '';

  _changeResultView(String button) {
    List<String> operators = ['+', '-', '×', '÷'];
    setState(() {
      if (!isOperator(button)) {
        _result += button;
      } else if (button == 'C') {
        _result = '';
      } else if (!_result.endsWith('${operators[0]} ') &&
          !_result.endsWith('${operators[1]} ') &&
          !_result.endsWith('${operators[2]} ') &&
          !_result.endsWith('${operators[3]} ')) {
        _result += ' $button ';
      }
    });
  }

  _calculateResult(String result) {
    if (result.split('').last != ' ') {
    List<String> temp;
    temp = result.split(' ');
      double finalResult = double.parse(temp[0]);
      for (int i = 1; i < temp.length; i += 2) {
        switch (temp[i]) {
          case '+':
            finalResult += double.parse(temp[i + 1]);
            break;
          case '-':
            finalResult -= double.parse(temp[i + 1]);
            break;
          case '×':
            finalResult *= double.parse(temp[i + 1]);
            break;
          case '÷':
            finalResult /= double.parse(temp[i + 1]);
            break;
        }
      }
      setState(() {
        _result = finalResult.toString();
      });
    }
  }

  _deleteLastChar(String result) {
    setState(() {
      if (_result.isNotEmpty) {
        if (_result.endsWith(' ')) {
          _result = _result.substring(0, _result.length - 3);
        } else {
          _result = _result.substring(0, _result.length - 1);
        }
      }
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
                      fontSize: 64,
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
                    } else if (_buttonChars[index] == '←') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(0xfffc9e4f),
                        Colors.white,
                        () => _deleteLastChar(_buttonChars[index]),
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
