import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/news/news_item.dart';

class NewsWiget extends StatelessWidget {
  Sources source;
  NewsWiget({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySoorceId(source.id ?? ''),
      builder: (context, snapshot) {
        // todo : loading ...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } //todo: client error
        else if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySoorceId(source.id ?? '');
                  },
                  child: Text(
                    'Try again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          );
        } //todo :server => respones => success , error
        //todo : server => error
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    ApiManager.getSources();
                  },
                  child: Text(
                    'Try again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          );
        }
        //todo: server=> response => success
        var newsList = snapshot.data?.articles ?? [];
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
}
