// concrete class
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news_app/data/repository/sources/repository/source_repository.dart';
import 'package:news_app/model/source_response.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;
  SourceRepositoryImpl({required this.sourceRemoteDataSource});
  @override
  Future<SourceResponse?> getSources() {
    return sourceRemoteDataSource.getsources();
  }
}
