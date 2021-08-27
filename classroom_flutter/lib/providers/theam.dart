import 'package:classroom_flutter/constants/theam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TheamProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
