import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appThemeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                //todo : change theme to dark
                appThemeProvider.changeTheme(ThemeMode.dark);
              },
              child: appThemeProvider.isDark()
                  ? getSelectedLanguageItem(
                      textTheme: AppLocalizations.of(context)!.dark)
                  : getUnSelectedLanguageItem(
                      textTheme: AppLocalizations.of(context)!.dark)),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
              onTap: () {
                //todo : change theme to light
                appThemeProvider.changeTheme(ThemeMode.light);
              },
              child: appThemeProvider.isDark()
                  ? getUnSelectedLanguageItem(
                      textTheme: AppLocalizations.of(context)!.light)
                  : getSelectedLanguageItem(
                      textTheme: AppLocalizations.of(context)!.light)),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textTheme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textTheme,
          style: AppStyles.bold20black,
        ),
        Icon(
          Icons.check,
          color: Colors.blue,
          size: 28,
        )
      ],
    );
  }

  Widget getUnSelectedLanguageItem({required String textTheme}) {
    return Text(textTheme, style: AppStyles.bold20black);
  }
}
