// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/Home/category_details/news/news_wiget.dart';
import 'package:news_app/ui/Home/category_details/source/source_name.dart';
import 'package:news_app/utils/app_colors.dart';

class SourceAppWidget extends StatefulWidget {
  List<Sources> sourcesList;

  SourceAppWidget({required this.sourcesList});

  @override
  State<SourceAppWidget> createState() => _SourceAppWidgetState();
}

class _SourceAppWidgetState extends State<SourceAppWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      child: Scaffold(
        
        body: Column(
          children: [
            TabBar(
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                tabAlignment: TabAlignment.start,
                dividerColor: AppColors.transparentColor,
                indicatorColor: Theme.of(context).indicatorColor,
                isScrollable: true,
                tabs: widget.sourcesList.map(
                  (source) {
                    return SourceName(
                        source: source,
                        isSelected:
                            selectedIndex == widget.sourcesList.indexOf(source));
                  },
                ).toList()),
           SizedBox(height: height*0.03 ,),
            Expanded(child: NewsWiget(source: widget.sourcesList[selectedIndex]))
          
          ],
        ),
      ),
      length: widget.sourcesList.length,
    );
  }
}
