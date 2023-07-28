extension DateComparison on DateTime {
  bool isSameYear(DateTime other) => year == other.year;
  bool isSameMonth(DateTime other) => isSameYear(other) && month == other.month;
  bool isSameDay(DateTime other) => isSameMonth(other) && day == other.day;
  bool isSameHour(DateTime other) => isSameDay(other) && hour == other.hour;
  bool isSameMinute(DateTime other) =>
      isSameHour(other) && minute == other.minute;
  bool isSameSecond(DateTime other) =>
      isSameMinute(other) && second == other.second;
}
