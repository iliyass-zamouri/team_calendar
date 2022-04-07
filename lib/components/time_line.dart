class TimeLine extends StatelessWidget {
  final Time startTime;
  final Time endTime;
  final TimeSlot timeSlot;
  final double timeSlotHeight;

  final ScrollController scroll;
  const TimeLine(
      {Key? key,
      required this.startTime,
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
          color: Colors.grey.withOpacity(0.15),
          border: Border(
              right: BorderSide(color: AppColors.kGray.withOpacity(0.6)))),
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
