import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Color _seedColor = Colors.teal;
  Color get seedColor => _seedColor;

  void setColor(Color color) {
    _seedColor = color;
    notifyListeners();
  }
}
