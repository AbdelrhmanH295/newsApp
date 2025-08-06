import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light; //defaoult
  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme; //update
    notifyListeners();
  }

  bool isDark() // check if the theme is dark
  {
    return appTheme == ThemeMode.dark;
  }
}
