import 'package:easy_localization/easy_localization.dart';

import '../../app/app.dart';

class LanguageService {
  // Get the current device language
  static String getLang() {
    String lang =
        EasyLocalization.of(
          myNavigatorKey.currentContext!,
        )!.locale.languageCode;
    return lang;
  }
}
