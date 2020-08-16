import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:schedule/widgets/text.dart';

class WeekViewWidget extends StatefulWidget {
  @override
  _WeekViewWidgetState createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
  List<FlutterWeekViewEvent> events = [];
  final _formKey = GlobalKey<FormState>();

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
                var start = DateTime(now.year, now.month, now.day,
                    Random().nextInt(24), Random().nextInt(60));
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
    showForm();
  }

  void showForm() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => new AlertDialog(
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: Colors.purple[600],),
          )
        ],
        title:  Center(
          child:  text("Nova Agenda",
              fontSize: 25, bold: true, color: Colors.purple[600]),
        ),
        contentPadding: EdgeInsets.all(15.0),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(11.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(0),
                height: height * 0.6,
                width: width + 400,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onTap: () async {
                        await showRoundedDatePicker(
                          theme: ThemeData(
                            primaryColor: Colors.purple[600],
                            accentColor: Colors.purple[600],
                          ),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 1),
                            lastDate: DateTime(DateTime.now().year + 1),
                            borderRadius: 16,
                        );
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.purple[600],
                        ),
                        labelText: 'Data',
                        labelStyle: TextStyle(color: Colors.purple[600]),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Data é obrigatório";
                        }
                        return null;
                      }
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.hourglass_empty,
                          color: Colors.purple[600],
                        ),
                        labelText: 'Hora',
                        labelStyle: TextStyle(color: Colors.purple[600]),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Hora é obrigatório";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.title,
                          color: Colors.purple[600],
                        ),
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.purple[600]),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Nome é obrigatório";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: Colors.purple[600],
                        ),
                        labelText: 'Descrição',
                        labelStyle: TextStyle(color: Colors.purple[600]),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Descrição é obrigatório";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: width - 40,
                      child: RaisedButton(
                        onPressed: () => saveShedule(context),
                        color: Colors.purple[600],
                        child: text("Salvar", color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  saveShedule(BuildContext context) {
    if (_formKey.currentState.validate()) {
      // save to database local.
    }
  }
}
