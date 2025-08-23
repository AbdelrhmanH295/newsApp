import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/impl/source_remote_data_source_impl.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news_app/data/repository/sources/repository/impl/source_repository_impl.dart';
import 'package:news_app/data/repository/sources/repository/source_repository.dart';

import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/cubit/sources_state.dart';

class SourcesViewModel extends Cubit<sourcesState> {
  late ApiManager apiManager;
  late SourceRepository sourceRepository;
  late SourceRemoteDataSource sourceRemoteDataSource;

  SourcesViewModel() : super(sourceLoadingState()) {
    apiManager = ApiManager();
    sourceRemoteDataSource = SourceRemoteDataSourceImpl(apiManager: apiManager);
    sourceRepository =
        SourceRepositoryImpl(sourceRemoteDataSource: sourceRemoteDataSource);
  }

  // hold data - handle Logic
  void getSources(String categoryId) async {
    try {
      emit(sourceLoadingState());
      var response = await sourceRepository.getSources();
      if (response?.status == 'error') {
        // server=> error
        emit(sourceErrorState(eerorMessage: response!.message!));
        return;
      }
      if (response?.sources == 'ok') {
        // server=> success
        emit(sourceSuccessState(sourcesList: response!.sources!));
        return;
      }
    } catch (e) {
      emit(sourceErrorState(eerorMessage: e.toString()));
    }
  }
}
