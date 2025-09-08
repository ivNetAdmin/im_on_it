class DateFormatHelper {
  static int fromDate(DateTime date){
    return date.microsecondsSinceEpoch;
  }

  static DateTime toDate(int seconds){
    return DateTime.fromMicrosecondsSinceEpoch(seconds);
  }
}