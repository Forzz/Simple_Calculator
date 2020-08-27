import 'package:flutter/material.dart';

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
  String _result = '';
  _changeResultView(String button) {
    setState(() {
      switch (button) {
        case '1':
          _result += button;
          break;
        case '2':
          _result += button;
          break;
        case '3':
          _result += button;
          break;
        case '4':
          _result += button;
          break;
        case '5':
          _result += button;
          break;
        case '6':
          _result += button;
          break;
        case '7':
          _result += button;
          break;
        case '8':
          _result += button;
          break;
        case '9':
          _result += button;
          break;
        case '0':
          _result += button;
          break;
        case 'C':
          _result = '';
          break;
        case '+':
          _result += ' $button ';
          break;
        case '-':
          _result += ' $button ';
          break;
        case '*':
          _result += ' $button ';
          break;
        case '÷':
          _result += ' $button ';
          break;
        case '÷':
          _result += ' $button ';
          break;
        case '=':
          _result = _calculateResult(_result);
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
      case '*':
        finalResult = firstNum * secondNum;
        break;
      case '÷':
        finalResult = firstNum / secondNum;
        break;
    }
    return finalResult.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                width: 200,
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _changeResultView('1');
                          },
                          child: Text(
                            '1',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('2');
                          },
                          child: Text(
                            '2',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('3');
                          },
                          child: Text(
                            '3',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('+');
                          },
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _changeResultView('4');
                          },
                          child: Text(
                            '4',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('5');
                          },
                          child: Text(
                            '5',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('6');
                          },
                          child: Text(
                            '6',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('-');
                          },
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _changeResultView('7');
                          },
                          child: Text(
                            '7',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('8');
                          },
                          child: Text(
                            '8',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('9');
                          },
                          child: Text(
                            '9',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('÷');
                          },
                          child: Text(
                            '÷',
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _changeResultView('C');
                          },
                          child: Text(
                            'С',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('0');
                          },
                          child: Text(
                            '0',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('=');
                          },
                          child: Text(
                            '=',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            _changeResultView('*');
                          },
                          child: Text(
                            '*',
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
