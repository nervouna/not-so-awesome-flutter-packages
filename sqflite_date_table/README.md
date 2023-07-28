# Sqflite Date Table

Populates a SQLite database with date-related data.

- `db` The database to populate.
- `startDate` The start date of the range to populate. Defaults to 2000-01-01 if `null`.
- `endDate` The end date of the range to populate. Defaults to 2100-12-31 if `null`.
- `tableName` The name of the table to populate. Defaults to 'dim_date'.

This function iterates through each day from `startDate` to `endDate` (inclusive), and for each day it adds a new row to
the 'dim_date' table with the following fields:
- 'date': the ISO 8601 string representation of the date
- 'year': the year of the date
- 'month': the month of the date
- 'day': the day of the month
- 'day_of_week': the day of the week, where Monday is 1 and Sunday is 7
- 'day_of_year': the day of the year
- 'week_of_year': the week of the year
- 'is_weekday': 1 if the date is a weekday (Monday-Friday), and 0 otherwise

If `startDate` or `endDate` is `null`, it defaults to 2000-01-01 or 2100-12-31 respectively.