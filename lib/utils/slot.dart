import 'package:team_calendar/models/time.dart';

class SlotCalc {
  static int timeSlotTimes(TimeSlot timeSlot) {
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
}