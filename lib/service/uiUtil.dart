import 'package:flutter/material.dart';

class UiUtil {
  Card customCard(
    String buttonText, {
    Color containerColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 17,
  }) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      elevation: 2,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
