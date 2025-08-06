import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';
  void changeLanguage(String newLanguge) {
    if (appLanguage == newLanguge) {
      return;
    }
    appLanguage = newLanguge;
    notifyListeners();
  }

  bool isEnglish() {
    return appLanguage == 'en';
  }
}
