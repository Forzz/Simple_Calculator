import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'widgets/calc_button.dart';
import 'icon_code/custom_icons.dart';

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
    '√',
    '^',
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

  bool _isInputLimit(String number) {
    return number.length < 15 ? true : false;
  }

  String _result = '';
  String _tempNumber = '';
  List<String> _allNumbers = List<String>();

  _changeResultView(String button) {
    List<String> operators = ['+', '-', '×', '÷', '^'];
    bool isProhibited = !_result.endsWith('+ ') &&
        !_result.endsWith('× ') &&
        !_result.endsWith('÷ ') &&
        !_result.endsWith('.') &&
        _tempNumber.isNotEmpty &&
        _tempNumber != '-';
    setState(() {
      if (!operators.contains(button) && _isInputLimit(_tempNumber)) {
        _result += button;
        _tempNumber += button;
      } else if (operators.contains(button)) {
        if (button == '-' && _tempNumber.isEmpty) {
          _result += '($button';
          _tempNumber += button;
        } else if (button == '-' &&
            _tempNumber.isNotEmpty &&
            _tempNumber != '-' &&
            !_result.endsWith('.')) {
          if (double.parse(_tempNumber) < 0) {
            _result += ') $button ';
          } else if (double.parse(_tempNumber) >= 0) {
            _result += ' $button ';
          }
          _allNumbers.add(_tempNumber);
          _tempNumber = '';
        } else if (button == '+' || button == '×' || button == '÷') {
          if (isProhibited) {
            if (double.parse(_tempNumber) < 0) {
              _result += ') $button ';
            } else if (double.parse(_tempNumber) >= 0) {
              _result += ' $button ';
            }
            _allNumbers.add(_tempNumber);
            _tempNumber = '';
          }
        } else if (button == '^') {
          if (isProhibited && !_result.split(' ').last.contains('^')) {
            if (double.parse(_tempNumber) < 0) {
              _result += ')^';
            } else if (double.parse(_tempNumber) >= 0) {
              _result += '^';
            }
            _allNumbers.add(_tempNumber);
            _tempNumber = '';
          }
        }
      }
    });
  }

  _calculateResult(String result) {
    if (result.split('').last != ' ') {
      List<String> tempList =
          result.replaceAll('(', '').replaceAll(')', '').split(' ');
      for (int i = 0; i < tempList.length; i++) {
        if (tempList[i].contains('^')) {
          tempList[i] = Math.pow(double.parse(tempList[i].split('^')[0]),
                  double.parse(tempList[i].split('^')[1]))
              .toString();
        }
      }
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
      if (tempList[0].endsWith('.0'))
        tempList[0] = tempList[0].substring(0, tempList[0].length - 2);
      setState(() {
        _result = tempList[0];
      });
      _isCanDelete = false;
    }
  }

  _sqrtOperation() {
    if (_result.split(' ').length == 1 &&
        _tempNumber.isNotEmpty &&
        _tempNumber != '-') {
      _result = Math.sqrt(double.parse(_result)).toStringAsFixed(9);
      setState(() {
        if (_result.endsWith('.000000000')) {
          _result = _result.substring(0, _result.length - 10);
        } else {
          _result = _result;
        }
      });
    }
  }

  bool _isCanDelete = true;

  _deleteLastChar() {
    if (_isCanDelete) {
      setState(() {
        if (_result.isNotEmpty) {
          if (_result.endsWith(' ')) {
            _result = _result.substring(0, _result.length - 3);
            _tempNumber = _allNumbers.removeLast();
          } else if (_result.endsWith('(-')) {
            _result = _result.substring(0, _result.length - 2);
            _tempNumber = '';
          } else {
            _result = _result.substring(0, _result.length - 1);
            _tempNumber = _tempNumber.substring(0, _tempNumber.length - 1);
          }
        }
      });
    }
  }

  _addDot(button) {
    if (!_tempNumber.contains(button)) {
      setState(() {
        if (_tempNumber.isNotEmpty) {
          if (_tempNumber == '-') {
            _tempNumber += '0$button';
            _result += '0$button';
          } else {
            _tempNumber += button;
            _result += button;
          }
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
    _isCanDelete = true;
  }

  int _resultWindowColor = 0xff2ca6a4;
  int _backgroundColor = 0xff9dd9d2;
  var _themeIcon = Custom.lampON;

  bool _isDark() {
    return _backgroundColor == 0xff9dd9d2 ? true : false;
  }

  _changeInterfaceColors() {
    setState(() {
      if (_isDark()) {
        _resultWindowColor = 0xff114140;
        _backgroundColor = 0xff225852;
        _themeIcon = Custom.lampOFF;
      } else {
        _resultWindowColor = 0xff2ca6a4;
        _backgroundColor = 0xff9dd9d2;
        _themeIcon = Custom.lampON;
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
                    Expanded(
                      flex: 3,
                      child: IconButton(
                        icon: Icon(_themeIcon),
                        padding: EdgeInsets.only(top: 30, right: 15),
                        color: Colors.white,
                        onPressed: _changeInterfaceColors,
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.centerRight,
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
                        () => _deleteLastChar(),
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
                    } else if (_buttonChars[index] == '√') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        null,
                        () => _sqrtOperation(),
                      );
                    } else if (_buttonChars[index] == '^') {
                      return CalcButton(
                        _buttonChars[index],
                        Color(_resultWindowColor),
                        Colors.white,
                        'Lato',
                        Custom.powMath,
                        () => _changeResultView(_buttonChars[index]),
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
