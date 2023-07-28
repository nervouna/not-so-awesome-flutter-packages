extension DateTimePartExtended on DateTime {
  int get dayOfYear => difference(DateTime(year, 1, 1)).inDays + 1;
  int get weekOfMonth => ((day - weekday + 10) / 7).floor();
  int get weekOfYear => ((dayOfYear - weekday + 10) / 7).floor();
}
