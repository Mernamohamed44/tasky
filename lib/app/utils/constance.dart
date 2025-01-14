import 'package:intl/intl.dart';

class AppConstance {
  static const String appFontName = 'DM Sans';

  // date & time & currency format
  static DateFormat dateFormat = DateFormat('dd-MM-yyyy', 'en');
  static DateFormat timeFormat = DateFormat('hh:mm a', 'en');
  static NumberFormat currencyFormat = NumberFormat("#,##0", "en_US");
  static DateFormat arabicDateFormat = DateFormat("d MMMM y", "ar");

  /// in case get date
  static DateFormat dateFormatVersed = DateFormat('yyyy-MM-dd', 'en');

  static DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    String formattedDateString =
        '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}T00:00:00.000';

    return DateTime.tryParse(formattedDateString) ?? DateTime.now();
  }
}
