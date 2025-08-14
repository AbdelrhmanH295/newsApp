import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/source/source_app_widget.dart';
import 'package:news_app/utils/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDetails({
    super.key, 
    required this.category,
    this.isSearchActive = false,
    this.searchQuery = '',
  });
  Category category;
  bool isSearchActive;
  String searchQuery;
  
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    // If search is active, show search results instead of sources
    if (widget.isSearchActive) {
      return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(widget.category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                    onPressed: () {
                      ApiManager.getSources(widget.category.id);
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
                SizedBox(
                  height: height * 0.03,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greyColor),
                    onPressed: () {
                      ApiManager.getSources(widget.category.id);
                      setState(() {});
                    },
                    child: Text(
                      'Try again',
                      style: TextStyle(color: AppColors.blackColor),
                    ))
              ],
            );
          }
          
          var sourcesList = snapshot.data?.sources ?? [];
          return SourceAppWidget(
            sourcesList: sourcesList,
            isSearchActive: widget.isSearchActive,
            searchQuery: widget.searchQuery,
          );
        },
      );
    }
    
    // Normal view with sources
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        //  loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ),
          );
        }
        // error => client
        else if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    ApiManager.getSources(widget.category.id);
                  },
                  child: Text(
                    'Try again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          );
        }
        // todo : server => response => success , error
        // todo : server=>error
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor),
                  onPressed: () {
                    ApiManager.getSources(widget.category.id);
                    setState(() {});
                  },
                  child: Text(
                    'Try again',
                    style: TextStyle(color: AppColors.blackColor),
                  ))
            ],
          );
        }
        // todo: server => success
        var sourcesList = snapshot.data?.sources ?? [];
        return SourceAppWidget(
          sourcesList: sourcesList,
          isSearchActive: widget.isSearchActive,
          searchQuery: widget.searchQuery,
        );
      },
    );
  }
}
