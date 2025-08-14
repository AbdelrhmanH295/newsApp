import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/ui/Home/category%20fragment/category_fragment.dart';
import 'package:news_app/ui/Home/category_details/category_details.dart';
import 'package:news_app/ui/Home/widgets/Language/language_button.dart';
import 'package:news_app/ui/Home/widgets/Theme/theme_button.dart';
import 'package:news_app/ui/Home/widgets/Language/drop_down_Language_container.dart';
import 'package:news_app/ui/Home/widgets/Theme/drop_down_Theme_container%20copy.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  VoidCallback? onDrawerItemClick;
  HomeScreen({super.key, required this.onDrawerItemClick});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          appBar: AppBar(
            title: isSearching
                ? TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).indicatorColor,
                      ),
                      hintText: 'Search...',
                      hintStyle:
                          TextStyle(color: Theme.of(context).indicatorColor),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: Theme.of(context).indicatorColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: Theme.of(context).indicatorColor, width: 1),
                      ),
                    ),
                    autofocus: true,
                  )
                :  Text(
                    selectedCategory == null
                        ? AppLocalizations.of(context)!.home
                        : selectedCategory!.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  icon: Icon(isSearching ? Icons.close : Icons.search))
            ],
            centerTitle: true,
            iconTheme: IconThemeData(color: Theme.of(context).indicatorColor),
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
                      onDrawerItemClick();
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
          body: Padding(padding: EdgeInsets.only(top: 10),
          child: selectedCategory == null
              ? CategoryFragment(
                  onCategoryItemClick: onCategoryItemClick,
                )
              : CategoryDetails(
                  category: selectedCategory!,
                )),) 
    );
  }

  Category? selectedCategory;

  void onCategoryItemClick(Category newSelectedCategory) {
// new selected category => user selected
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  void onDrawerItemClick() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
