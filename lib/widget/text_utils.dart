import 'package:flutter/material.dart';

class TextUtils extends Text {
  TextUtils(String text, {color: Colors.black, textscaleFactor: 1.0})
      : super(text,
            textScaleFactor: textscaleFactor,
            textAlign: TextAlign.center,
            style: new TextStyle(color: color));
}
