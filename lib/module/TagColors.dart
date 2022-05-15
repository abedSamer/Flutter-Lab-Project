import 'package:flutter/material.dart';

class TagColors {
  // var selectedColor = Color(0xFF2196F3);

  List<int> getColorAsARGB(String color) {
    //color ex. : FF 11 22 33
    List value = color.toString().split("");
    String A = value[0] + value[1],
        R = value[2] + value[3],
        G = value[4] + value[5],
        B = value[6] + value[7];

    return [
      int.parse('$A', radix: 16),
      int.parse('$R', radix: 16),
      int.parse('$G', radix: 16),
      int.parse('$B', radix: 16)
    ];
  }

  Map<String, Color> colors1 = {
    'red': Color(0xFFF44336),
    'green': Color(0xFF4CAF50),
    'blue': Color(0xFF2196F3),
    'white': Color(0xFFFFFFFF),
    'yellow': Color(0xFFFFFF00),
    'lightBlue': Color(0xFF03A9F4),
    'myBlue': Color(0x1321E0),
    'lightPink': Color(0xFFF28B81),
    'lightYellow': Color(0xFFFBF476),
    'lightGreen': Color(0xFFCDFF90),
    'turquoise': Color(0xFFA7FEEB),
    'lightCyan': Color(0xFFCBF0F8),
    'plum': Color(0xFFD7AEFC),
    'lightBrown': Color(0xFFE6C9A9),
    'lightGray': Color(0xFFE9EAEE),
  };

  List<Color> colors = [
    Color(0xFFF44336),
    Color(0xFF4CAF50),
    Color(0xFF2196F3),
    Color(0xFFFFBB00),
    Color(0xFF03A9F4),
    Color(0xFF1321E0),
    Color(0xFFF28B81),
    Color(0xFFFBF476),
    Color(0xFFCDFF90),
    Color(0xFFA7FEEB),
    Color(0xFFCBF0F8),
    Color(0xFFD7AEFC),
    Color(0xFFE6C9A9),
    Color(0xFFE9EAEE),
  ];
}
