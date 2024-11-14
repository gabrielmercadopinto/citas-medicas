import 'package:intl/intl.dart';
import 'package:citas_medicas/models/time_slot_model.dart';

class AppHelper{
  static List<TimeSlot> calculateTimeSlots(String startTime, String endTime, int slotDuration) {
    final format = DateFormat.Hm();
    DateTime start = format.parse(startTime);
    DateTime end = format.parse(endTime);
    List<TimeSlot> slots = [];

    while (start.isBefore(end)) {
      DateTime slotEnd = start.add(Duration(minutes: slotDuration));
      if (slotEnd.isAfter(end)) break;

      slots.add(TimeSlot(
        startTime: format.format(start),
        endTime: format.format(slotEnd),
      ));

      start = slotEnd;
    }

    return slots;
  }

  static TimeSlot calculateSlot(String startTime, int slotDuration, int slot) {
    
    print("$startTime, $slotDuration, $slot");
    final format = DateFormat.Hm();
    DateTime start = format.parse(startTime);
    DateTime slotStart = start.add(Duration(minutes: (slot) * slotDuration));
    DateTime slotEnd = slotStart.add(Duration(minutes: slotDuration));

    return TimeSlot(
      startTime: format.format(slotStart),
      endTime: format.format(slotEnd),
    );
}
}