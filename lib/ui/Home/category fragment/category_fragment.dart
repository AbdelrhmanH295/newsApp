import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/ui/Home/category%20fragment/category_item.dart';
import 'package:news_app/ui/Home/category_details/news/news_item.dart';
import 'package:provider/provider.dart';

typedef OnCategoryItemClick = void Function(Category);

class CategoryFragment extends StatefulWidget {
  CategoryFragment({
    super.key, 
    required this.onCategoryItemClick,
    this.isSearchActive = false,
    this.searchQuery = '',
  });
  OnCategoryItemClick onCategoryItemClick;
  bool isSearchActive;
  String searchQuery;

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  List<Category> categoriesList = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // If search is active, show search results instead of categories
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
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Text(
                  'Search results for: "${widget.searchQuery}"',
                  style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: ListView.separated(
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
                    itemCount: newsList.length),
              ),
            ],
          );
        },
      );
    }

    categoriesList = Category.getCategoriesList(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Good Morning\nHere is Some News For You',
            style: TextStyle(
                color: Theme.of(context).indicatorColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //todo: show category details ..
                      widget.onCategoryItemClick(categoriesList[index]);
                      setState(() {});
                    },
                    child: CategoryItem(
                      index: index,
                      category: categoriesList[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: height * 0.02,
                  );
                },
                itemCount: categoriesList.length),
          ),
        ],
      ),
    );
  }
}
