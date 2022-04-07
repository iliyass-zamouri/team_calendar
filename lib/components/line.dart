import 'package:flutter/material.dart';
import 'package:team_calendar/components/header.dart';
import 'package:team_calendar/configurations/scroll_config.dart';
import 'package:team_calendar/models/header.dart';
import 'package:team_calendar/models/line.dart';
import 'package:team_calendar/models/time.dart';
import 'package:team_calendar/utils/slot.dart';

class LineComponent extends StatelessWidget {
  final ScrollController scroll;
  final double height;
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
    return SizedBox(
      width: 200,
      child: ScrollConfiguration(
        behavior: NoSwipeScroll(),
        child: SingleChildScrollView(
          controller: scroll,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HeaderComponent(
                name: "Hamza",
                header: line.header,
                height: headerHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      right: BorderSide(color: borderColor.withOpacity(0.2))),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
