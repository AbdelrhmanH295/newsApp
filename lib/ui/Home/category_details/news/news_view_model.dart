import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/news_response.dart';

class NewsViewModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;
  void getNewsBySourceId(String sourceId) async {
    var response = await ApiManager.getNewsBySoorceId(sourceId);
    try {
      if (response?.status == 'error') {
        // error => server
        errorMessage = response!.message!;
      } else {
        // success
        newsList = response!.articles;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
