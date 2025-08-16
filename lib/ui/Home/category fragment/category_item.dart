import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  int index;
  CategoryItem({super.key, required this.category, required this.index});
  Category category;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment:
          (index % 2 == 0) ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(category.image),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: height * 0.01, horizontal: width * 0.02),
          padding: EdgeInsetsDirectional.only(
              start: (index % 2 == 0) ? width * 0.02 : 0,
              end: (index % 2 != 0) ? width * 0.02 : 0),
          width: width * 0.4,
          height: height * 0.06,
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(84),
          ),
          child: Row(
            textDirection:
                (index % 2 != 0) ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('View All',
                  style: Theme.of(context).textTheme.headlineLarge),
              CircleAvatar(
                  radius: 26,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: (index % 2 == 0)
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).indicatorColor,
                        )
                      : Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).indicatorColor,
                        )),
            ],
          ),
        )
      ],
    );
  }
}
