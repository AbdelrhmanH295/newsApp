// interface class
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/news_response.dart';

abstract class NewsRepository {
  Future<NewsResponse?> getNewsBySoorceId(String sourceId);
}
