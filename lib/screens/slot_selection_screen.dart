import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:citas_medicas/models/time_slot_model.dart';
import 'package:citas_medicas/screens/appointment_confirmation_screen.dart';

class SlotSelectionScreen extends StatelessWidget {
  final String doctorScheduleId;
  final String doctorName;
  final String specialityName;
  final List<TimeSlot> slots;
  final List<int> reservedSlots;

  const SlotSelectionScreen({
    Key? key,
    required this.doctorScheduleId,
    required this.doctorName,
    required this.specialityName,
    required this.slots, 
    required this.reservedSlots, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Slot Selection Screen $doctorScheduleId, $doctorName, $specialityName");
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Schedule')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: slots.length,
        itemBuilder: (context, index) {
          final slot = slots[index];
          if(!reservedSlots.contains(index)){
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('$index : ${slot.startTime} - ${slot.endTime}'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {       
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentConfirmationScreen(
                        doctorScheduleId: doctorScheduleId,
                        doctorName: doctorName,
                        specialityName: specialityName,
                        selectedSlot: slot,
                        index: index
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Card(
            color: AppColors.errorColor,
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('$index : ${slot.startTime} - ${slot.endTime}'),
              ),
            );
        },
      ),
    );
  }
}
