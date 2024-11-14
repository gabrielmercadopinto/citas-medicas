import 'package:citas_medicas/core/config/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:citas_medicas/screens/slot_selection_screen.dart';
import 'package:citas_medicas/models/doctor_shedule_model.dart';
import 'package:citas_medicas/providers/doctor_shedule_provider.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';


class DoctorScheduleScreen extends StatelessWidget {
  static const String routeName = "doctor_shedules";
  final String specialityId;
  final int dayOfWeek;

  const DoctorScheduleScreen({
    super.key, 
    required this.specialityId, 
    required this.dayOfWeek
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DoctorScheduleProvider>(context, listen: false);
    // print("DoctorSheduleScreen: Day: $dayOfWeek - Spaciality: $specialityId");
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Schedules')),
      body: FutureBuilder(
        future: provider.fetchSchedules(dayOfWeek, specialityId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Consumer<DoctorScheduleProvider>(
            builder: (context, provider, child) {

              if (provider.schedules.isEmpty) {
                return const Center(child: Text('No schedules available for this speciality and day.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: provider.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = provider.schedules[index];
                  return GestureDetector(
                    onTap: () {
                      final slots = AppHelper.calculateTimeSlots(schedule.startTime, schedule.endTime, schedule.slotDuration);  
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SlotSelectionScreen(
                            doctorScheduleId: schedule.id,                            
                            doctorName: schedule.doctor.user.fullName,
                            specialityName: schedule.speciality.name,                          
                            slots: slots,
                            reservedSlots: schedule.reservedSlots,
                          ),
                        ),
                      );
                    },
                    child: DoctorInformation(schedule: schedule),
                  );
                },
              );            
            },
          );
        },
      ),
    );
  }
}

class DoctorInformation extends StatelessWidget {
  const DoctorInformation({
    super.key,
    required this.schedule,
  });

  final DoctorSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),                  
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  schedule.doctor.user.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.local_hospital,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Speciality: ${schedule.speciality.name}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.room,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Room: ${schedule.consultingRoom.roomName} (${schedule.consultingRoom.roomLocation})',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Shedule: ${schedule.startTime} - ${schedule.endTime}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Date Duration: ${schedule.slotDuration} mins',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),                          
          ],
        ),
      ),
    );
  }
}
