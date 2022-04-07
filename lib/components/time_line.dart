import 'package:flutter/material.dart';
import 'package:team_calendar/configurations/scroll_config.dart';
import 'package:team_calendar/models/time.dart';
import 'package:team_calendar/models/time_line_style.dart';
import 'package:team_calendar/utils/expand_equally.dart';
import 'package:team_calendar/utils/slot.dart';

class TimeLineComponent extends StatelessWidget {
  final Time startTime;
  final Time endTime;
  final TimeSlot timeSlot;
  final TimeLineStyle style;
  final double timeSlotHeight;

  final ScrollController scroll;
  const TimeLineComponent(
      {Key? key,
      required this.startTime,
      this.style = const TimeLineStyle(),
      required this.endTime,
      required this.timeSlotHeight,
      required this.timeSlot,
      required this.scroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: style.backgroundColor,
          border: Border(
              right: BorderSide(color: style.borderColor.withOpacity(0.6)))),
      child: ScrollConfiguration(
        behavior: NoSwipeScroll(),
        child: ListView.builder(
          controller: scroll,
          padding: EdgeInsets.zero,
          itemCount: endTime.hour - startTime.hour,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: index == 0 ? timeSlotHeight - 8 : 0),
              height: timeSlotHeight * Slot.calc(timeSlot),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 1; i <= Slot.calc(timeSlot); i++)
                    Container(
                      // height: timeSlotHeight - 0.08,
                      child: Text(
                        startTime.refactor(i, index),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 12),
                      ),
                    )
                ].expandEqually().toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
