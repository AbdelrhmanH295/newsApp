import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/ui/Home/category_details/news/news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsViewModel() : super(NewsLoadingState());
  void getNewsById(String sourceId) async {
    try {
      // loading ..
      emit(NewsLoadingState());
      var response = await ApiManager.getNewsBySoorceId(sourceId);
      if (response?.status == 'error') {
        // error
        emit(NewsErrorState(errorMessage: response!.message!));
        return;
      }
      if (response?.status == 'ok') {
        emit(NewsSuccessState(newsList: response!.articles!));
        return;
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
