import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/source/source_app_widget.dart';
import 'package:news_app/utils/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(),
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
                    ApiManager.getSources();
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
                    ApiManager.getSources();
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
        );
      },
    );
  }
}
