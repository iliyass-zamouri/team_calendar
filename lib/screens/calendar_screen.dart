import 'package:flutter/material.dart';
import 'package:team_calendar/components/line.dart';
import 'package:team_calendar/components/time_line.dart';
import 'package:team_calendar/configurations/scroll_config.dart';
import 'package:team_calendar/models/line.dart';
import 'package:team_calendar/models/time.dart';
import 'package:team_calendar/models/time_line_style.dart';
import 'package:team_calendar/scroll_engine.dart';
import 'package:team_calendar/utils/slot.dart';

class TeamCalendar extends StatefulWidget {
  final List<Line> resources;
  final Time startTime;
  final Time endTime;
  final TimeLineStyle timeLineStyle;
  final TimeSlot timeSlot;
  final double timeSlotWidth;
  final double timeSlotHeight;
  const TeamCalendar({
    Key? key,
    this.resources = const <Line>[],
    required this.startTime,
    required this.endTime,
    this.timeLineStyle = const TimeLineStyle(),
    this.timeSlotHeight = 50,
    this.timeSlotWidth = 40,
    this.timeSlot = TimeSlot.thirteen,
  }) : super(key: key);

  @override
  State<TeamCalendar> createState() => _TeamCalendarState();
}

late ScrollLinker _scrollLinker;
List<ScrollController> _scrollControllers = <ScrollController>[];

class _TeamCalendarState extends State<TeamCalendar> {
  @override
  void initState() {
    super.initState();
    _scrollLinker = ScrollLinker();

    _scrollControllers.add(ScrollController());
    for (int i = 0; i < widget.resources.length; i++) {
      _scrollControllers.add(ScrollController());
    }

    _lineHeight = (Slot.calc(widget.timeSlot) * widget.timeSlotHeight);
  }

  @override
  void dispose() {
    for (ScrollController controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  late double _lineHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiDirectional ScrollView'),
        elevation: 0,
      ),
      body: SizedBox(
          width: 1000,
          child: ScrollConfiguration(
            behavior: NoSwipeScroll(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.resources.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return TimeLineComponent(
                    startTime: widget.startTime,
                    endTime: widget.endTime,
                    timeSlot: widget.timeSlot,
                    timeSlotHeight: widget.timeSlotHeight,
                    scroll: _scrollControllers[index],
                    style: widget.timeLineStyle,
                  );
                } else {
                  return LineComponent(
                    scroll: _scrollControllers[index],
                    line: widget.resources[index - 1],
                    height: _lineHeight,
                    headerHeight: widget.timeSlotHeight,
                    borderColor: Colors.grey,
                    timeSlot: widget.timeSlot,
                    timeSlotHeight: widget.timeSlotHeight,
                    startTime: widget.startTime,
                    endTime: widget.endTime,
                  );
                }
              },
            ),
          )),
    );
  }
}
