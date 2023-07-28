library sqflite_date_table;

import 'package:intl/intl.dart';
import 'package:sqflite/sqlite_api.dart';

/// Populates a SQLite database with date-related data.
///
/// - `db` The database to populate.
/// - `startDate` The start date of the range to populate. Defaults to 2000-01-01 if `null`.
/// - `endDate` The end date of the range to populate. Defaults to 2100-12-31 if `null`.
/// - `tableName` The name of the table to populate. Defaults to 'dim_date'.
///
/// This function iterates through each day from `startDate` to `endDate` (inclusive), and for each day it adds a new row to
/// the 'dim_date' table with the following fields:
/// - 'date': the ISO 8601 string representation of the date
/// - 'year': the year of the date
/// - 'month': the month of the date
/// - 'day': the day of the month
/// - 'day_of_week': the day of the week, where Monday is 1 and Sunday is 7
/// - 'day_of_year': the day of the year
/// - 'week_of_year': the week of the year
/// - 'is_weekday': 1 if the date is a weekday (Monday-Friday), and 0 otherwise
///
/// If `startDate` or `endDate` is `null`, it defaults to 2000-01-01 or 2100-12-31 respectively.
void populateDateData(
  Database db, {
  DateTime? startDate,
  DateTime? endDate,
  String tableName = 'dim_date',
}) async {
  List<Map<String, dynamic>> dateData = [];

  // Default start and end dates
  startDate ??= DateTime(2000, 1, 1);
  endDate ??= DateTime(2100, 12, 31);

  // Day increment for loop
  const dayIncrement = Duration(days: 1);

  // Iterates from startDate to endDate
  while (startDate!.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
    int year = startDate.year;
    int month = startDate.month;
    int day = startDate.day;
    int dayOfWeek = startDate.weekday;

    // Formatting startDate to obtain day of the year
    int dayOfYear = int.parse(DateFormat('D').format(startDate));

    // Calculation for week of the year
    int weekOfYear = ((dayOfYear - dayOfWeek + 10) / 7).floor();

    // If dayOfWeek < 6 it's a weekday
    int isWeekday = (dayOfWeek < 6) ? 1 : 0;

    // Adds a new row to the dateData list
    dateData.add({
      'date': startDate.toIso8601String(),
      'year': year,
      'month': month,
      'day': day,
      'day_of_week': dayOfWeek,
      'day_of_year': dayOfYear,
      'week_of_year': weekOfYear,
      'is_weekday': isWeekday
    });

    // Increment the date by one day
    startDate = startDate.add(dayIncrement);
  }

  // Start writing data to database in a batch
  final batch = db.batch();

  // Loop through the dateData list and add each map to the batch
  for (final row in dateData) {
    batch.insert(tableName, row);
  }

  // Commit the batch to the database
  await batch.commit();
}
