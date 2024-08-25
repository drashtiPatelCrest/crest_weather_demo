import 'package:intl/intl.dart';

class DateTimeUtil {
  static String convertDateFormat(String? inputDate) {
    if (inputDate == null) {
      return '';
    }
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('MMM dd, hh:mm a').format(dateTime);
    return formattedDate;
  }

  static String convertShortDate(String? inputDate) {
    if (inputDate == null) {
      return '';
    }
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('MMM dd, EEE').format(dateTime);
    return formattedDate;
  }
}
