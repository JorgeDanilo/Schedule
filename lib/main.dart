
import 'package:flutter/material.dart';
import 'package:schedule/pages/profile.dart';
import 'package:schedule/widgets/week_view_widget.dart';

void main() => runApp(_FlutterWeekViewApp());

class _FlutterWeekViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Schedule',
    initialRoute: '/',
    routes: {
      '/': (context) => Profile(),
    },
  );
}