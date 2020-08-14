import 'package:flutter/material.dart';

Text text(String text,
    {double fontSize = 16,
    color = Colors.black,
    bold = false,
    italic = false}) {
  return Text(
    text ?? "",
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: "Roboto",
      decoration: TextDecoration.none,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    ),
  );
}
