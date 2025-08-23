import 'package:news_app/model/news_response.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponse?> getNewsBySoorceId(String sourceId);
}
