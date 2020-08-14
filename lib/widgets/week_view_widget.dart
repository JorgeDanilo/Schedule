import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class WeekViewWidget extends StatefulWidget {
  @override
  _WeekViewWidgetState createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
  List<FlutterWeekViewEvent> events = [];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                var start = DateTime(now.year, now.month, now.day,
                    Random().nextInt(24), Random().nextInt(60));
                events.add(
                  FlutterWeekViewEvent(
                      title: "Event " + (events.length + 1).toString(),
                      start: start,
                      end: start.add(const Duration(hours: 1)),
                      description: "A description"),
                );
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: WeekView(
        style: WeekViewStyle(headerSize: 25, dayViewSeparatorColor: Colors.purple[600]),
        onDayBarTappedDown: (date) {
          print(date);
        },
        onHoursColumnTappedDown: (dateTime) {
          print(dateTime);
        },
          initialTime: const HourMinute(hour: 7).atDate(DateTime.now()),
          dates: [
            date.subtract(const Duration(days: 1)),
            date,
            date.add(const Duration(days: 1))
          ],
          events: events),
    );
  }

  addHour(minute) {

  }
}
