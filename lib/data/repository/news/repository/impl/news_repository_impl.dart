import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news/repository/news_repository.dart';
import 'package:news_app/model/news_response.dart';

class NewsRepositoryImpl implements NewsRepository {
  ApiManager apiManager;
  NewsRepositoryImpl({required this.apiManager});
  @override
  Future<NewsResponse?> getNewsBySoorceId(String sourceId) {
    return apiManager.getNewsBySoorceId(sourceId);
  }
}
