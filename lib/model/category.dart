import 'package:flutter/material.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_images.dart';
import 'package:provider/provider.dart';

class Category {
  String id;
  String title;
  String image;

  Category({required this.id, required this.image, required this.title});

  static List<Category> getCategoriesList(BuildContext context) {
    var appThemeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isDark = appThemeProvider.isDark();
    return [
      Category(
          id: 'general',
          image: isDark ? AppImages.genral_dark : AppImages.genral_light,
          title: 'Genral'),
      Category(
          id: 'business',
          image: isDark ? AppImages.busniess_dark : AppImages.busniess_light,
          title: 'Business'),
      Category(
          id: 'sports',
          image: isDark ? AppImages.sports_dark : AppImages.sports_light,
          title: 'Sports'),
      Category(
          id: 'technology',
          image:
              isDark ? AppImages.technology_dark : AppImages.technology_light,
          title: 'Technology'),
      Category(
          id: 'entertainment',
          image: isDark
              ? AppImages.entertainment_dark
              : AppImages.entertainment_light,
          title: 'Entertainment'),
      Category(
          id: 'health',
          image: isDark ? AppImages.health_dark : AppImages.health_light,
          title: 'Health'),
      Category(
          id: 'science',
          image: isDark ? AppImages.science_dark : AppImages.science_light,
          title: 'Science'),
    ];
  }
}
