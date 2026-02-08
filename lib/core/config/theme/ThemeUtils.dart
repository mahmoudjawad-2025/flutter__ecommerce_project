import 'package:flutter/material.dart';

class ThemeUtils {
  //-------------------------------------------------------------------------- Colors
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const black = Colors.black;
  static const red = Colors.red;
  static const displayMediumColor = Color.fromARGB(255, 1, 15, 28);

  //-------------------------------------------------------------------------- methods
  static bool isDarkColor(Color color) => color.computeLuminance() < 0.5;
}
