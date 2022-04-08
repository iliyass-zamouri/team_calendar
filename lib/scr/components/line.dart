import 'package:flutter/material.dart';
import 'package:team_calendar/scr/components/header.dart';
import 'package:team_calendar/scr/configurations/scroll_config.dart';
import 'package:team_calendar/scr/models/appointment.dart';
import 'package:team_calendar/scr/models/line.dart';
import 'package:team_calendar/scr/models/time.dart';
import 'package:team_calendar/scr/utils/slot.dart';

class LineComponent extends StatelessWidget {
  final ScrollController scroll;
  final double height;
  final double width;
  final Line line;
  final Color borderColor;
  final double timeSlotHeight;
  final TimeSlot timeSlot;
  final Time startTime;
  final Time endTime;
  final double headerHeight;
  const LineComponent({
    Key? key,
    required this.line,
    required this.height,
    required this.width,
    required this.headerHeight,
    required this.borderColor,
    required this.timeSlot,
    required this.timeSlotHeight,
    required this.startTime,
    required this.endTime,
    required this.scroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: width,
          child: ScrollConfiguration(
            behavior: NoSwipeScroll(),
            child: SingleChildScrollView(
              controller: scroll,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: headerHeight,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              right: BorderSide(
                                  color: borderColor.withOpacity(0.2))),
                        ),
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ((endTime.hour - startTime.hour) *
                                      Slot.calc(timeSlot)) *
                                  2,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: (timeSlotHeight / 2),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: borderColor.withOpacity(
                                          0.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      for (Appointment appointment in line.appointments)
                        Container(
                          margin: EdgeInsets.only(
                              top: timeSlotHeight * Slot.calc(timeSlot)),
                          height: timeSlotHeight * Slot.calc(timeSlot),
                          width: width,
                          decoration: BoxDecoration(
                              color: appointment.color,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            appointment.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: HeaderComponent(
            header: line.header,
            height: headerHeight,
            width: width,
          ),
        ),
      ],
    );
  }
}
