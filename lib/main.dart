
import 'package:flutter/material.dart';
import 'package:schedule/widgets/week_view_widget.dart';

void main() => runApp(_FlutterWeekViewApp());

class _FlutterWeekViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Schedule',
    initialRoute: '/',
    routes: {
      '/': (context) => WeekViewWidget(),
    },
  );
}