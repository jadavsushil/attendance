import 'package:flutter/material.dart';

class ColorConst {
  static Color appColor = Color.fromRGBO(248, 249, 251, 1);
  static Color appHighLightColor = Color.fromRGBO(117, 184, 227, 1);
  static Color greyColor = Color.fromRGBO(174, 177, 181, 1);
  static Color redColor = Color.fromRGBO(198, 48, 72, 1);
  static Color greenColor = Color.fromRGBO(118, 169, 78, 1);
  static Color blueColor = Colors.blue;

  static List<Color> groupColor = [
    ColorConst.appHighLightColor,
    ColorConst.redColor,
    ColorConst.greenColor
  ];

  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.replaceFirst("#", "0xFF")));
  }
}
