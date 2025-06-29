import 'package:timeago/timeago.dart';

class ArabicCustomMessages implements LookupMessages {
  @override String prefixAgo() => 'منذ';
  @override String prefixFromNow() => 'بعد';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'الآن';
  @override String aboutAMinute(int minutes) => 'دقيقة واحدة';
  @override String minutes(int minutes) => '$minutes دقائق';
  @override String aboutAnHour(int minutes) => 'ساعة واحدة';
  @override String hours(int hours) => '$hours ساعات';
  @override String aDay(int hours) => 'يوم واحد';
  @override String days(int days) => '$days أيام';
  @override String aboutAMonth(int days) => 'شهر واحد';
  @override String months(int months) => '$months أشهر';
  @override String aboutAYear(int year) => 'سنة واحدة';
  @override String years(int years) => '$years سنوات';
  @override String wordSeparator() => ' ';
}