import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String input;
  final textColor;
  final color;
  final fontFamily;
  final icon;
  final buttonTapped;

  const CalcButton(
    this.input,
    this.color,
    this.textColor,
    this.fontFamily,
    this.icon,
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
          child: this.icon == null
              ? Text(
                  input,
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                    fontFamily: fontFamily,
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
