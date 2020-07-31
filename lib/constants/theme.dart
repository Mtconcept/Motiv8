import 'package:flutter/material.dart';
import 'package:motiv8/constants/colors.dart';

final darkTheme = ThemeData(
    primaryColor: Coloors.kWhite,
    brightness: Brightness.dark,
    backgroundColor: Coloors.kPrimaryColors,
    accentColor: Coloors.kAccentColors,
    buttonColor: Coloors.kBtnColor);

final lightTheme = ThemeData(
    primaryColor: Coloors.kPrimaryColors,
    brightness: Brightness.light,
    backgroundColor: Coloors.kWhite,
    accentColor: Coloors.kPrimaryColors,
    buttonColor: Coloors.kBtnColor);
    

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);
  getTheme() => _themeData;
  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
