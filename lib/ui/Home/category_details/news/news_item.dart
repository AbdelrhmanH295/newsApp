import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  News news;
  NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.01, vertical: height * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: Theme.of(context).indicatorColor, width: 1)),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: AppColors.greyColor,
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            news.description ?? '',
            style: TextStyle(color: Theme.of(context).indicatorColor),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'By : ${getFirstTwoWords(news.author ?? '')}',
                  style: TextStyle(color: AppColors.greyColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                timeago.format(DateTime.parse(news.publishedAt ?? '').toLocal(),
                    locale: 'en'),
                style: TextStyle(color: AppColors.greyColor),
              )
            ],
          )
        ],
      ),
    );
  }

  String getFirstTwoWords(String? text) {
    if (text == null || text.trim().isEmpty) return '';
    final words = text.trim().split(' ');
    if (words.length <= 2) return text;
    return '${words[0]} ${words[1]}';
  }
}
