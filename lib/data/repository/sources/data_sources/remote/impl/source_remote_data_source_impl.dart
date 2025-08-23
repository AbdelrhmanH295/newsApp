import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news_app/model/source_response.dart';

class SourceRemoteDataSourceImpl implements SourceRemoteDataSource {
  // impl sourceRemoteDataSource
  ApiManager apiManager;
  SourceRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<SourceResponse?> getsources() async {
    var response = await apiManager.getSources();
    return response;
  }
}
