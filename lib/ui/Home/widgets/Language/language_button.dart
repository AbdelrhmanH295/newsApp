import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                //todo : change lang to english
                languageProvider.changeLanguage('en');
              },
              child: languageProvider.appLanguage == 'en'
                  ? getSelectedLanguageItem(
                      textLanguage: AppLocalizations.of(context)!.english)
                  : getUnSelectedLanguageItem(
                      textLanguage: AppLocalizations.of(context)!.english)),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
              onTap: () {
                //todo : change lang to english
                languageProvider.changeLanguage('ar');
              },
              child: languageProvider.appLanguage == 'ar'
                  ? getSelectedLanguageItem(
                      textLanguage: AppLocalizations.of(context)!.arabic)
                  : getUnSelectedLanguageItem(
                      textLanguage: AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textLanguage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textLanguage,
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

  Widget getUnSelectedLanguageItem({required String textLanguage}) {
    return Text(textLanguage, style: AppStyles.bold20black);
  }
}
