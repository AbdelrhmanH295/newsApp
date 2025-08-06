import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/ui/Home/category_details/category_details.dart';
import 'package:news_app/ui/Home/widgets/Language/language_button.dart';
import 'package:news_app/ui/Home/widgets/Theme/theme_button.dart';
import 'package:news_app/ui/Home/widgets/Language/drop_down_Language_container.dart';
import 'package:news_app/ui/Home/widgets/drop_down_Theme_container%20copy.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).indicatorColor),
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.home,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Color(0xff171717),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: AppColors.whiteColor),
                  child: Center(
                      child: Text(
                    'News App',
                    style: AppStyles.bold20black,
                  ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: AppColors.whiteColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Text(
                        AppLocalizations.of(context)!.go_to_home,
                        style: AppStyles.bold24White,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                endIndent: 35,
                indent: 25,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.format_paint_outlined,
                          color: AppColors.whiteColor,
                          size: 30,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          AppLocalizations.of(context)!.theme,
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                    DropDownThemeContainer(
                      showButtonSheet: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ThemeButton(),
                        );
                      },
                    ),
                    Divider(
                      thickness: 1,
                      endIndent: 35,
                      indent: 25,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: AppColors.whiteColor,
                          size: 30,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          AppLocalizations.of(context)!.app_language,
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                    DropDownLanguageContainer(
                      showButtonSheet: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => LanguageButton(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                endIndent: 35,
                indent: 25,
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
        body: CategoryDetails());
  }
}
