import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:nativys_pro/shared/app_colors.dart';

enum TimeSlot { fifteen, thirteen, oclock }

class Time {
  final int hour;
  final int min;
  const Time(this.hour, this.min) : assert(hour < 24 && min < 60);

  String refactor(int times, int add) {
    switch (times) {
      case 1:
        return stringify(hour + add) + ":" + stringify(min);
      case 2:
        return stringify(hour + add) + ":" + stringify(min + 15);
      case 3:
        return stringify(hour + add) + ":" + stringify(min + 30);
      case 4:
        return stringify(hour + add) + ":" + stringify(min + 45);
      default:
        return "";
    }
  }

  String stringify(int number) => number < 10 ? "0$number" : number.toString();
}

class BiDirectionalScrollView extends StatefulWidget {
  final TimeSlot timeSlot;
  final Time startTime;
  final Time endTime;
  final double timeSlotWidth;
  final double timeSlotHeight;
  final List<AgendaEvent> events;
  const BiDirectionalScrollView({
    Key key,
    @required this.startTime,
    @required this.endTime,
    this.events,
    this.timeSlotHeight = 50,
    this.timeSlotWidth = 40,
    this.timeSlot = TimeSlot.thirteen,
  }) : super(key: key);

  @override
  State<BiDirectionalScrollView> createState() =>
      _BiDirectionalScrollViewState();
}

LinkedScrollControllerGroup _controllers;
ScrollController _scroll1;
ScrollController _scroll2;
ScrollController _scroll3;
ScrollController _scroll4;
ScrollController _scroll0;

class _BiDirectionalScrollViewState extends State<BiDirectionalScrollView> {
  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _scroll0 = _controllers.addAndGet();
    _scroll1 = _controllers.addAndGet();
    _scroll2 = _controllers.addAndGet();
    _scroll3 = _controllers.addAndGet();
    _scroll4 = _controllers.addAndGet();
    _lineHeight = (_timeSlotTimes(widget.timeSlot) * widget.timeSlotHeight);
  }

  double _lineHeight;

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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TimeLine(
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  timeSlotHeight: widget.timeSlotHeight,
                  timeSlot: widget.timeSlot,
                  scroll: _scroll4,
                ),
                Line(
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  scroll: _scroll0,
                  timeSlot: widget.timeSlot,
                  timeSlotHeight: widget.timeSlotHeight,
                  height: _lineHeight,
                  headerHeight: widget.timeSlotHeight,
                ),
                Line(
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  timeSlot: widget.timeSlot,
                  timeSlotHeight: widget.timeSlotHeight,
                  scroll: _scroll1,
                  height: _lineHeight,
                  headerHeight: widget.timeSlotHeight,
                ),
                Line(
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  timeSlot: widget.timeSlot,
                  timeSlotHeight: widget.timeSlotHeight,
                  scroll: _scroll2,
                  height: _lineHeight,
                  headerHeight: widget.timeSlotHeight,
                ),
                Line(
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  scroll: _scroll3,
                  timeSlot: widget.timeSlot,
                  height: _lineHeight,
                  timeSlotHeight: widget.timeSlotHeight,
                  headerHeight: widget.timeSlotHeight,
                ),
              ],
            ),
          )),
    );
  }
}

class TimeLine extends StatelessWidget {
  final Time startTime;
  final Time endTime;
  final TimeSlot timeSlot;
  final double timeSlotHeight;

  final ScrollController scroll;
  const TimeLine(
      {Key key,
      this.startTime,
      this.endTime,
      this.timeSlotHeight,
      this.timeSlot,
      @required this.scroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          border: Border(
              right: BorderSide(color: AppColors.kGray.withOpacity(0.6)))),
      child: ScrollConfiguration(
        behavior: NoSwipeScroll(),
        child: ListView.builder(
          controller: scroll,
          padding: EdgeInsets.zero,
          itemCount: endTime.hour - startTime.hour,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: index == 0 ? timeSlotHeight - 8 : 0),
              height: timeSlotHeight * _timeSlotTimes(timeSlot),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 1; i <= _timeSlotTimes(timeSlot); i++)
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

int _timeSlotTimes(TimeSlot timeSlot) {
  switch (timeSlot) {
    case TimeSlot.oclock:
      return 1;

    case TimeSlot.thirteen:
      return 2;

    case TimeSlot.fifteen:
      return 4;

    default:
      return 1;
  }
}

class Line extends StatelessWidget {
  final ScrollController scroll;
  final double height;
  final double timeSlotHeight;
  final TimeSlot timeSlot;
  final Time startTime;
  final Time endTime;
  final headerHeight;
  const Line({
    Key key,
    @required this.height,
    this.headerHeight,
    this.timeSlot,
    this.timeSlotHeight,
    @required this.startTime,
    @required this.endTime,
    @required this.scroll,
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
            physics: NeverScrollableScrollPhysics(),
            children: [
              AgendaHeader(
                name: "Hamza",
                height: headerHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      right:
                          BorderSide(color: AppColors.kGray.withOpacity(0.2))),
                ),
                child: SingleChildScrollView(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ((endTime.hour - startTime.hour) *
                              _timeSlotTimes(timeSlot)) *
                          2,
                      itemBuilder: (context, index) {
                        return Container(
                          height: (timeSlotHeight / 2),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: AppColors.kGray.withOpacity(
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

class AgendaHeader extends StatelessWidget {
  final String name;
  final double height;

  const AgendaHeader({Key key, this.name, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: AppColors.kGray.withOpacity(0.6)),
      )),
      width: 200,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() =>
      map((widget) => Expanded(flex: 1, child: widget));
}

class NoSwipeScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class AgendaEvent {
  final String title;

  final String subtitle;

  final Time start;

  final Time end;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final VoidCallback onTap;

  final BoxDecoration decoration;

  final Color backgroundColor;

  final TextStyle textStyle;

  final TextStyle subtitleStyle;

  AgendaEvent({
    @required this.title,
    this.subtitle = "",
    @required this.start,
    @required this.end,
    this.padding = const EdgeInsets.all(10),
    this.margin,
    this.onTap,
    this.decoration,
    this.backgroundColor = const Color(0xFF323D6C),
    this.textStyle = const TextStyle(
        color: Color(0xFF535353), fontSize: 11, fontWeight: FontWeight.w400),
    this.subtitleStyle =
        const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF363636)),
  });
}
