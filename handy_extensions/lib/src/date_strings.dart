extension DateStrings on DateTime {
  String toIso8601DateString() => toIso8601String().split('T').first;
}
