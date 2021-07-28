import 'package:cosmic_instant/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cosmic_instant/extensions/date_time_apis.dart';
import 'package:intl/intl.dart';


void main() {

  DateTime nowToSeconds() {
    var now = DateTime.now();
    var duration = Duration(
        milliseconds: now.millisecond, microseconds: now.microsecond
    );
    return now.subtract(duration);
  }

  testWidgets('Local date is formatted properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Get the date
    var finder = find.byKey(Key('cosmic-date'));
    var dateText = finder.evaluate().single.widget as Text;

    // Verify that the date exists
    expect(dateText.data, isNotNull);

    // TODO will this fail if day of month is one digit?
    var exp = RegExp(r"^\w{3} \d{2}, \d{4}$");
    var matches = exp.hasMatch(dateText.data!);
    expect(matches, isTrue);

  });

  testWidgets('Local time is formatted properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Get the time
    var finder = find.byKey(Key('cosmic-time'));
    var timeText = finder.evaluate().single.widget as Text;

    // Verify that the time exists
    expect(timeText.data, isNotNull);

    var exp = RegExp(r"^\d{1,2}:\d{2}:\d{2} [A|P]M$");
    var matches = exp.hasMatch(timeText.data!);
    expect(matches, isTrue);

  });

  testWidgets('Local instant is valid', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var before = nowToSeconds();
    await tester.pumpWidget(MyApp());
    var after = nowToSeconds();

    // Get the date and time
    var finder = find.byKey(Key('cosmic-date'));
    var dateText = finder.evaluate().single.widget as Text;
    finder = find.byKey(Key('cosmic-time'));
    var timeText = finder.evaluate().single.widget as Text;

    // build DateTime from  the two fields
    var cosmicDate = DateFormat('MMM dd, yyyy').parse(dateText.data!);
    var cosmicTime = DateFormat('hh:mm:ss aa').parse(timeText.data!);
    var cosmicDateTime = DateTime(
      cosmicDate.year,
      cosmicDate.month,
      cosmicDate.day,
      cosmicTime.hour,
      cosmicTime.minute,
      cosmicTime.second,
    );

    // Verify that the time instance is in range
    var range = DateTimeRange(start: before, end: after);
    expect(cosmicDateTime.inRange(range), isTrue);
  });

  testWidgets('UTC instant is formatted properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the utc time is displayed
    var utcInstantFinder = find.byKey(Key('utc-instant'));
    var utcInstantText = utcInstantFinder.evaluate().single.widget as Text;
    expect(utcInstantText.data, isNotNull);

    var exp = RegExp(r"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}$");
    var matches = exp.hasMatch(utcInstantText.data!);
    expect(matches, isTrue);
  });

  testWidgets('ISO instant is formatted properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the utc time is displayed
    var isoInstantFinder = find.byKey(Key('iso-instant'));
    var isoInstantText = isoInstantFinder.evaluate().single.widget as Text;
    expect(isoInstantText.data, isNotNull);

    var exp = RegExp(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d{3}-\d{2}:\d{2}$");
    var matches = exp.hasMatch(isoInstantText.data!);
    expect(matches, isTrue);
  });
}