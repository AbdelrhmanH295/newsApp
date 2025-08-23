import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news/data_sources/remote/news_remote_data_source.dart';
import 'package:news_app/model/news_response.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;
  NewsRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<NewsResponse?> getNewsBySoorceId(String sourceId)async {
    var respone = await apiManager.getNewsBySoorceId(sourceId);
    return respone ;
  }
}
