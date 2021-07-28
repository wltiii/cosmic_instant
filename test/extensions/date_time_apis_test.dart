import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cosmic_instant/extensions/date_time_apis.dart';

void main() {
  group('inRange tests', () {
    test('inRange returns true when date is between start and end range', () {
      var start = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var between = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var end = DateTime.now();

      var range = DateTimeRange(start: start, end: end);

      expect(between.inRange(range), isTrue);
    });

    test('true when date equals start date', () {
      var start = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var end = DateTime.now();

      var between = DateTime(
          start.year,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond
      );

      var range = DateTimeRange(start: start, end: end);

      expect(between.inRange(range), isTrue);
    });

    test('true when date equals end date', () {
      var start = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var end = DateTime.now();

      var between = DateTime(
          end.year,
          end.month,
          end.day,
          end.hour,
          end.minute,
          end.second,
          end.millisecond,
          end.microsecond
      );

      var range = DateTimeRange(start: start, end: end);

      expect(between.inRange(range), isTrue);
    });

    test('false when date is before range start', () {
      var before = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var start = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var end = DateTime.now();

      var range = DateTimeRange(start: start, end: end);

      expect(before.inRange(range), isFalse);
    });

    test('false when date is after range end', () {
      var start = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var end = DateTime.now();
      sleep(new Duration(milliseconds: 10));
      var after = DateTime.now();

      var range = DateTimeRange(start: start, end: end);

      expect(after.inRange(range), isFalse);
    });
  });

  group('isoFormatWithOffset', () {
    var moonLandingZulu = DateTime.parse('1969-07-20 20:18:04.123Z');

    test('returns 0 hour offset for UTC', () {
      expect(moonLandingZulu.toIso8601StringWithOffset(), '1969-07-20T20:18:04.123+00:00');
    });

    test('returns 5 hour offset for US Central (DST)', () {
      expect(moonLandingZulu.toLocal().toIso8601StringWithOffset(), '1969-07-20T15:18:04.123-05:00');
    });
  });

}