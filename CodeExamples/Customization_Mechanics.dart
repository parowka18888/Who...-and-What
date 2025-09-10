import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';

class Customization_Mechanics{
  static void changeLanguage(BuildContext context) {
    List<String> languages = ['pl', 'en', 'de'];
    Locale current = Localizations.localeOf(context);

    int currentIndex = languages.indexOf(current.languageCode);
    if(currentIndex == languages.length - 1){
      currentIndex = -1;
    }
    int nextIndex = (currentIndex + 1);

    String nextLanguageCode = languages[nextIndex];
    context.setLocale(Locale(nextLanguageCode));
  }

}