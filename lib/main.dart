import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApplication());
}

class CalculatorApplication extends StatefulWidget {
  const CalculatorApplication({super.key});

  @override
  State<CalculatorApplication> createState() => _CalculatorApplicationState();
}

class _CalculatorApplicationState extends State<CalculatorApplication> {
  var inputUser = '';
  var resultCalculator = '';

  void _buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  bool _isOperator(String text) {
    final operators = ['ac', 'ce', '%', '/', '+', '-', '*', '='];
    for (var item in operators) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color _getBackgroundColor(String text) {
    if (_isOperator(text)) {
      return backgroundGreyDark;
    }
    return backgroundGrey;
  }

  Color _getTextColor(String text) {
    if (_isOperator(text)) {
      return textGreen;
    }
    return textGrey;
  }

  Widget _getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                resultCalculator = '';
              });
            } else {
              _buttonPressed(text1);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: _getBackgroundColor(text1),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: _getTextColor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              _buttonPressed(text2);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: _getBackgroundColor(text2),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: _getTextColor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _buttonPressed(text3);
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: _getBackgroundColor(text3),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: _getTextColor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text4 == "=") {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double res =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                resultCalculator = res.toString();
              });
            } else {
              _buttonPressed(text4);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: _getBackgroundColor(text4),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: _getTextColor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundGreyDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 26, color: textGreen),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          resultCalculator,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 62,
                              fontWeight: FontWeight.bold,
                              color: textGrey),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getRow('ac', 'ce', '%', '/'),
                      _getRow('7', '8', '9', '*'),
                      _getRow('4', '5', '6', '-'),
                      _getRow('1', '2', '3', '+'),
                      _getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
                flex: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
