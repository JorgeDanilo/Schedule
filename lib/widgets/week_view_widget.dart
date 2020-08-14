import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:schedule/widgets/text.dart';

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
        centerTitle: true,
        title: const Text("Agenda"),
        backgroundColor: Colors.purple[600],
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                var start = DateTime(now.year, now.month, now.day, Random().nextInt(24), Random().nextInt(60));
                events.add(
                  FlutterWeekViewEvent(
                      onTap: () => showSchedule(context),
                      backgroundColor: Colors.purple[600],
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
          userZoomable: true,
          onHoursColumnTappedDown: (dateTime) {
            print(dateTime);
            showForm();
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

  showSchedule(BuildContext context) {
    print("checked here");
    showForm();
  }

  void showForm() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;
                  return Container(
                    height: height * 0.5,
                    width: width * 0.2,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: text("Nova Agenda", fontSize: 20, bold: true, color: Colors.purple[600]),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                             icon: Icon(Icons.title, color: Colors.purple[600],),
                              labelText: 'Nome',
                              labelStyle: TextStyle(color: Colors.purple[600]),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            icon: Icon(Icons.description, color: Colors.purple[600],),
                            labelText: 'Descrição',
                            labelStyle: TextStyle(color: Colors.purple[600]),
                          ),
                        ),
                        SizedBox(height: 100,),
                        Container(
                          width: 300,
                          child: RaisedButton(
                            onPressed: () {},
                            color: Colors.purple[600],
                            child: text("Salvar", color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }
}
