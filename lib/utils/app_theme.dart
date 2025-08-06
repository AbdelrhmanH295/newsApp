import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class Apptheme {
  static final ThemeData lightTheme = ThemeData(
    indicatorColor: AppColors.blackColor,
      textTheme: TextTheme(
        labelMedium: AppStyles.semi14black,
          labelLarge: AppStyles.bold20black.copyWith(fontSize: 16),
          headlineLarge: AppStyles.bold24black),
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(color: AppColors.whiteColor));

  static final ThemeData darkTheme = ThemeData(
    indicatorColor: AppColors.whiteColor,
      textTheme: TextTheme(
          labelLarge: AppStyles.bold24White.copyWith(fontSize: 18),
          headlineLarge: AppStyles.bold24White,
          labelMedium: AppStyles.semi14white),
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: AppBarTheme(color: AppColors.blackColor));
}
