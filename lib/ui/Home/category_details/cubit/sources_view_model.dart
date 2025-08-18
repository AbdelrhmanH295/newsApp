import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/cubit/sources_state.dart';

class SourcesViewModel extends Cubit<sourcesState> {
  SourcesViewModel() : super(sourceLoadingState());
  // hold data - handle Logic
  void getSources() {
    ApiManager.getSources();
  }
}
