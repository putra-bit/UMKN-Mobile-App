import 'package:flutter/material.dart';

class ProviderTheme with ChangeNotifier{
  ThemeData _themeData = ThemeData.light();

  ThemeData get themedata => _themeData;

  bool get isDarkMode => _themeData == ThemeData.dark();

  void ubahTema(){
    _themeData = isDarkMode ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}