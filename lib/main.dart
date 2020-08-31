import 'package:flutter/material.dart';

import 'widgets/calc_button.dart';
import 'icon_code/custom_icons_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    'C',
    ' ',
    ' ',
    '←',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '×',
    '.',
    '0',
    '=',
    '÷'
  ];

  bool isOperator(String input) {
    List<String> operators = ['+', '-', '×', '÷', '='];
    return operators.contains(input);
  }

  bool isInputLimit(String number) {
    return number.length < 15 ? true : false;
  }

  String _result = '';
  String _tempNumber = '';
  List<String> allNumbers = List<String>();

  _changeResultView(String button) {
    List<String> arithOp = ['+', '-', '×', '÷'];
    setState(() {
      if (isInputLimit(_tempNumber) && !isOperator(button)) {
        _tempNumber += button;
        _result += button;
      } else if (_result.isNotEmpty &&
          isOperator(button) &&
          !arithOp.contains(
              _result.substring(_result.length - 2, _result.length - 1))) {
        allNumbers.add(_tempNumber);
        _tempNumber = '';
        _result += ' $button ';
      }
    });
  }

  _calculateResult(String result) {
    if (result.split('').last != ' ') {
      List<String> tempList = result.split(' ');
      for (int i = 0; i < tempList.length; i++) {
        if (tempList[i] == '÷') {
          tempList[i] =
              (double.parse(tempList[i - 1]) / double.parse(tempList[i + 1]))
                  .toString();
          tempList.removeAt(i + 1);
          tempList.removeAt(i - 1);
          i = 0;
        } else if (tempList[i] == '×') {
          tempList[i] =
              (double.parse(tempList[i - 1]) * double.parse(tempList[i + 1]))
                  .toString();
          tempList.removeAt(i + 1);
          tempList.removeAt(i - 1);
          i = 0;
        }
      }
      for (int i = 0; i < tempList.length; i++) {
        if (tempList[i] == '+') {
          tempList[i] =
              (double.parse(tempList[i - 1]) + double.parse(tempList[i + 1]))
                  .toString();
          tempList.removeAt(i + 1);
          tempList.removeAt(i - 1);
          i = 0;
        } else if (tempList[i] == '-') {
          tempList[i] =
              (double.parse(tempList[i - 1]) - double.parse(tempList[i + 1]))
                  .toString();
          tempList.removeAt(i + 1);
          tempList.removeAt(i - 1);
          i = 0;
        }
      }
      setState(() {
        _result = tempList[0];
      });
    }
  }

  _deleteLastChar(String result) {
    setState(() {
      if (_result.isNotEmpty) {
        if (_result.endsWith(' ')) {
          _result = _result.substring(0, _result.length - 3);
          _tempNumber = allNumbers.removeLast();
        } else {
          _result = _result.substring(0, _result.length - 1);
          _tempNumber = _tempNumber.substring(0, _tempNumber.length - 1);
        }
      }
    });
  }

  _addDot(button) {
    if (!_tempNumber.contains(button)) {
      setState(() {
        if (_tempNumber.isNotEmpty) {
          _tempNumber += button;
          _result += button;
        } else if (_tempNumber.isEmpty) {
          _tempNumber += '0$button';
          _result += '0$button';
        }
      });
    }
  }

  _cleanAll() {
    setState(() {
      _result = '';
      _tempNumber = '';
    });
  }

  int _resultWindowColor = 0xff2ca6a4;
  int _backgroundColor = 0xff9dd9d2;
  var _themeIcon = CustomIcons.lamp;

  bool _isDark() {
    return _backgroundColor == 0xff9dd9d2 ? true : false;
  }

  _changeInterfaceColors() {
    setState(() {
      if (_isDark()) {
        _resultWindowColor = 0xff114140;
        _backgroundColor = 0xff225852;
        _themeIcon = CustomIcons.lightbulb;
      } else {
        _resultWindowColor = 0xff2ca6a4;
        _backgroundColor = 0xff9dd9d2;
        _themeIcon = CustomIcons.lamp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_backgroundColor),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(_resultWindowColor),
                  border: Border.all(color: Color(_resultWindowColor)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(_themeIcon),
                      padding: EdgeInsets.only(top: 30, right: 15),
                      color: Colors.white,
                      onPressed: _changeInterfaceColors,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          _result,
                          style: TextStyle(
                            fontSize: 64,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
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
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        null,
                        () => _calculateResult(_result),
                      );
                    } else if (_buttonChars[index] == '←') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        Icons.arrow_back,
                        () => _deleteLastChar(_buttonChars[index]),
                      );
                    } else if (_buttonChars[index] == 'C') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        null,
                        () => _cleanAll(),
                      );
                    } else if (_buttonChars[index] == '.') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        null,
                        () => _addDot(_buttonChars[index]),
                      );
                    } else {
                      return CalcButton(
                        _buttonChars[index],
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        null,
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
