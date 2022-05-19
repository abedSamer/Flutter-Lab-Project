import 'package:flutter/material.dart';

class TagColors {
  String getColorFromList(int index) {
    String _tremedColor =
        colors[index].toString().split("Color(0x")[1].split(")")[0];
    return _tremedColor;
  }

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
