import 'package:flutter/material.dart';

extension DateRange on DateTime {
  // Convenience method that validates this DateTime instance
  // is within the range, inclusive.
  bool inRange(DateTimeRange range) {
    return range.start.compareTo(this) <= 0 && range.end.compareTo(this) >= 0;
  }
}

extension Format on DateTime {
  String toIso8601StringWithOffset() {
    return _toUnzonedIsoDateToMillis(this) + _buildTimeZoneOffset(this);
  }
}

String _toUnzonedIsoDateToMillis(DateTime dateTime) {
  var s = dateTime.toIso8601String();
  var ms = dateTime.microsecond.toString();

  s = s.endsWith('Z') ? s.substring(0, s.lastIndexOf('Z')) : s;
  return s.endsWith(ms) ? s.substring(0, s.lastIndexOf(ms)) : s;
}

String _buildTimeZoneOffset(DateTime dateTime) {
  final duration = dateTime.timeZoneOffset;

  final offsetHours = duration.inHours.abs().toString().padLeft(2, '0');

  final offsetMinutes =
  (duration.inMinutes.abs() - (duration.inHours.abs() * 60))
      .toString()
      .padLeft(2, '0');
  final offsetString = "$offsetHours:$offsetMinutes";

  return duration.isNegative ? "-" + offsetString : "+" + offsetString;
}