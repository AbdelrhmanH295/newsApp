import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart'; // as http refer to when need somthing form pack use 'http' as ref.

/* 
https://newsapi.org/v2/everything?q=bitcoin&apiKey=2b7e78a8883b46ec90cc4cbba6f52100
*/
class ApiManager {
  static Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi,
        {'apiKey': ApiConstants.apiKey, 'category': categoryId});
    var response = await http.get(url);
    try {
      var responseBody = response.body; //todo: String
      //Todo : String=> json
      var json = jsonDecode(responseBody); //todo : json
      //json=>object
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> getNewsBySoorceId(String sourceId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,
        {'apiKey': ApiConstants.apiKey, 'sources': sourceId});
    var response =
        await http.get(url); // talking to server and respones in body
    try {
      var responseBody = response.body; // STRING
      var json =
          jsonDecode(responseBody); //json ... i need to convert it to object
      return NewsResponse.fromJson(json); // we have now obj
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> searchNews(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,
        {'apiKey': ApiConstants.apiKey, 'q': query});
    var response = await http.get(url);
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
