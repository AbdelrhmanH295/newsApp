// todo : interface repository remote ds.
import 'package:http/http.dart';
import 'package:news_app/model/source_response.dart';

abstract class SourceRemoteDataSource {
  Future<SourceResponse?> getsources();
}
