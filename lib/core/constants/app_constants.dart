import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const int paginationLimit = 4;
  static final String? arabicFont = GoogleFonts.cairo().fontFamily;
  static final String? englishFont = GoogleFonts.openSans().fontFamily;
  static const String remoteMessage = 'remoteMessage';
  static const String tokenKey = 'token';
  static const String userDataKey = 'userDataKey';
  static const String onboardingKey = 'onboarding';
  static const String onboardingValue = 'show';
  static const String rs = '\uFDFC';
  static const String isTerminateNotification = 'terminate';
  static const Duration timeOut = Duration(seconds: 15);
  static const Duration searchTime = Duration(milliseconds: 1500);
  static const String filter = 'filter';
  static const String search = 'search';
  static const String original = 'original';
  static const int splashTimer = 3;
  static const bool lightMode = false;
  static const bool darkMode = true;
}
