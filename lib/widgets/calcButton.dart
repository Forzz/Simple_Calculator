import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String input;
  final textColor;
  final color;
  final buttonTapped;

  const CalcButton(
    this.input,
    this.color,
    this.textColor,
    this.buttonTapped,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          color: color,
          child: Text(
            input,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }
}
