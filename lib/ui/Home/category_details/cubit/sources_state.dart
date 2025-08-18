import 'package:news_app/model/source_response.dart';

abstract class sourcesState {}

class sourceLoadingState extends sourcesState {}

class sourceErrorState extends sourcesState {
  String eerorMessage;
  sourceErrorState({required this.eerorMessage});
}

class sourceSuccessState extends sourcesState {
  List<Sources> sourcesList;
  sourceSuccessState({required this.sourcesList});
}
