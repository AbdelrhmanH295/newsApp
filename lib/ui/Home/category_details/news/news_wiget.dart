import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/news/news_item.dart';
import 'package:news_app/ui/Home/category_details/news/news_states.dart';
import 'package:news_app/ui/Home/category_details/news/news_view_model.dart';

class NewsWiget extends StatefulWidget {
  Sources? source;
  bool isSearchActive;
  String searchQuery;

  NewsWiget({
    super.key,
    this.source,
    this.isSearchActive = false,
    this.searchQuery = '',
  });

  @override
  State<NewsWiget> createState() => _NewsWigetState();
}

class _NewsWigetState extends State<NewsWiget> {
  NewsViewModel viewModel = NewsViewModel();
  @override
 
@override
void didUpdateWidget(covariant NewsWiget oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.source?.id != widget.source?.id) {
    viewModel.getNewsById(widget.source!.id ?? '');
  }
}

  @override
  Widget build(BuildContext context) {
//     if (!widget.isSearchActive && widget.source != null) {
//   viewModel.getNewsById(widget.source!.id ?? '');
// }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // If search is active and we have a query, use search API
    if (widget.isSearchActive && widget.searchQuery.isNotEmpty) {
      return FutureBuilder<NewsResponse?>(
        future: ApiManager.searchNews(widget.searchQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                    onPressed: () {
                      ApiManager.searchNews(widget.searchQuery);
                    },
                    child: Text(
                      'Try again',
                      style: Theme.of(context).textTheme.labelMedium,
                    ))
              ],
            );
          }

          if (snapshot.data?.status != 'ok') {
            return Column(
              children: [
                Text(
                  snapshot.data!.message!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                    onPressed: () {
                      // Refresh search
                    },
                    child: Text(
                      'Try again',
                      style: Theme.of(context).textTheme.labelMedium,
                    ))
              ],
            );
          }

          var newsList = snapshot.data?.articles ?? [];
          if (newsList.isEmpty) {
            return Center(
              child: Text(
                'No news found for "${widget.searchQuery}"',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                return NewsItem(
                  news: newsList[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: height * 0.02,
                );
              },
              itemCount: newsList.length);
        },
      );
    }

    // Normal news display for a specific source
    if (widget.source == null) {
      return Center(
        child: Text(
          'No source selected',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return BlocBuilder<NewsViewModel, NewsStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is NewsErrorState) {
          return Column(
            children: [
              Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    viewModel.getNewsById(widget.source!.id ?? '');
                  },
                  child: Text(
                    'Try again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          );
        } else if (state is NewsSuccessState) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return NewsItem(
                  news: state.newsList[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: height * 0.02,
                );
              },
              itemCount: state.newsList.length);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // FutureBuilder<NewsResponse?>(
    //   future: ApiManager.getNewsBySoorceId(widget.source!.id ?? ''),
    //   builder: (context, snapshot) {
    //     // todo : loading ...
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } //todo: client error
    //     else if (snapshot.hasError) {
    //       return Column(
    //         children: [
    //           Text(
    //             'Something went wrong',
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //               onPressed: () {
    //                 ApiManager.getNewsBySoorceId(widget.source!.id ?? '');
    //               },
    //               child: Text(
    //                 'Try again',
    //                 style: Theme.of(context).textTheme.labelMedium,
    //               ))
    //         ],
    //       );
    //     } //todo :server => respones => success , error
    //     //todo : server => error
    //     if (snapshot.data?.status != 'ok') {
    //       return Column(
    //         children: [
    //           Text(
    //             snapshot.data!.message!,
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //               onPressed: () {
    //                 // ApiManager.getSources();
    //               },
    //               child: Text(
    //                 'Try again',
    //                 style: Theme.of(context).textTheme.labelMedium,
    //               ))
    //         ],
    //       );
    //     }
    //     //todo: server=> response => success
    //     var newsList = snapshot.data?.articles ?? [];
    //     return ListView.separated(
    //         itemBuilder: (context, index) {
    //           return NewsItem(
    //             news: newsList[index],
    //           );
    //         },
    //         separatorBuilder: (context, index) {
    //           return SizedBox(
    //             height: height * 0.02,
    //           );
    //         },
    //         itemCount: newsList.length);
    //   },
    // );
  }
}
