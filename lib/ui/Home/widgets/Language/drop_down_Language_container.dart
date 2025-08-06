import 'package:flutter/material.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/ui/Home/widgets/Language/language_button.dart';
import 'package:news_app/ui/Home/widgets/Theme/theme_button.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DropDownLanguageContainer extends StatefulWidget {
  VoidCallback showButtonSheet;
  DropDownLanguageContainer({super.key, required this.showButtonSheet});

  @override
  State<DropDownLanguageContainer> createState() =>
      _DropDownLanguageContainerState();
}

class _DropDownLanguageContainerState extends State<DropDownLanguageContainer> {
  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<LanguageProvider>(context);
    var appThemeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: AppColors.whiteColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLanguageProvider.isEnglish()
                ? AppLocalizations.of(context)!.english
                : AppLocalizations.of(context)!.arabic,
            style: AppStyles.bold24White.copyWith(fontSize: 20),
          ),
          InkWell(
            onTap: widget.showButtonSheet,
            child: Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.whiteColor,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

  void showThemeButtonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeButton(),
    );
  }
}
