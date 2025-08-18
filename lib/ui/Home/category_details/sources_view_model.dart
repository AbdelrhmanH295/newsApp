import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/source_response.dart';

class SourcesViewModel extends ChangeNotifier {
  // hold Data - handel Logic
  List<Sources>? sourcesList;
  String? errorMessage;
  void getSources(String categoryId) async {
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response?.status == 'error') {
        // todo : error
        errorMessage = response!.message!;
      } else {
        // todo : success
        sourcesList = response!.sources!;
      }
    } catch (e) {
      errorMessage = e.toString(); 
    }
    notifyListeners();
  }
}
