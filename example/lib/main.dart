import 'package:flutter/material.dart';
import 'package:team_calendar/scr/models/appointment.dart';
import 'package:team_calendar/scr/models/header.dart';
import 'package:team_calendar/scr/models/line.dart';
import 'package:team_calendar/scr/models/time.dart';
import 'package:team_calendar/scr/screens/calendar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TeamCalendarExample(title: 'Team Calendar'),
    );
  }
}

class TeamCalendarExample extends StatefulWidget {
  const TeamCalendarExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TeamCalendarExample> createState() => _TeamCalendarExampleState();
}

class _TeamCalendarExampleState extends State<TeamCalendarExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TeamCalendar(
        resources: [
          Line(
              header: Header(
                title: 'Amine',
              ),
              appointments: [
                Appointment(
                    title: 'title',
                    start: const Time(10, 0),
                    end: const Time(12, 0),
                    onTap: () {
                      print('tap');
                    }),
              ]),
          Line(
              header: Header(
                title: 'Amine',
              ),
              appointments: []),
          Line(
              header: Header(
                title: 'Amine',
              ),
              appointments: []),
          Line(
              header: Header(
                title: 'Amine',
              ),
              appointments: [])
        ],
        startTime: const Time(8, 0),
        endTime: const Time(20, 0),
        timeSlot: TimeSlot.fifteen,
        timeSlotHeight: 50,
        timeSlotWidth: 40,
      ),
    );
  }
}
