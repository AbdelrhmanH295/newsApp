import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:news_app/model/news_response.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  News news;
  NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onDoubleTap: () {
        // To DO : show bottom sheet
        showBottomSheet(
          enableDrag: true,
          backgroundColor: AppColors.transparentColor,
          context: context,
          builder: (context) => Container(
            height: 450,
            margin: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            // padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(
                width: 6,
                color: Theme.of(context).indicatorColor,
              ),
              color: Theme.of(context).indicatorColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: AppColors.greyColor,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(news.content!,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(news.url!);
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('There is an error in url $url');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: height*0.01),
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color:Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'View Full Article',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      child: Container(
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
                  timeago.format(
                      DateTime.parse(news.publishedAt ?? '').toLocal(),
                      locale: 'en'),
                  style: TextStyle(color: AppColors.greyColor),
                )
              ],
            )
          ],
        ),
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
