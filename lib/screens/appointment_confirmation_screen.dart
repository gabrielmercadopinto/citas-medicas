// ignore_for_file: use_build_context_synchronously

import 'package:citas_medicas/controllers/appointment_controller.dart';
import 'package:citas_medicas/core/graphql/graphql_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:citas_medicas/components/costom_button.dart';
import 'package:citas_medicas/core/config/app_preferences.dart';
import 'package:citas_medicas/models/time_slot_model.dart';
import 'package:citas_medicas/screens/home_screen.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final String doctorScheduleId;
  final String doctorName;
  final String specialityName;
  final int index;
  final TimeSlot selectedSlot;

  const AppointmentConfirmationScreen({
    Key? key,
    required this.doctorScheduleId,
    required this.doctorName,
    required this.specialityName,
    required this.index,
    required this.selectedSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Confirm: Slot: ${selectedSlot.startTime} - ${selectedSlot.endTime}, Doctor Schedule: $doctorScheduleId, Index: $index");
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Appointment')),
      body: Padding(        
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [            
            AppointmentCard(doctorName: doctorName, specialityName: specialityName, selectedSlot: selectedSlot),    
            const SizedBox(height: 10),
            Center(
              child: CustomButton(
                height: 40,
                color: AppColors.primaryColor, 
                text: "Confirm Appointment", 
                onTap: () async {
                  try {
                    
                    final appointmentController = AppointmentController(GraphQLConfig.getClient());
                    await appointmentController.createAppointment(
                      slotNumber: index,
                      doctorScheduleId: doctorScheduleId,
                    );

                    
                    final date = DateTime.now();
                    final appointment = DateFormat('yyyy-MM-dd').format(date);
                    final pref = AppPreferences();
                    pref.lastDateAppointment = appointment;
                    

                    showTopSnackBar(context, "Appointment Confirmed!", backgroundColor: AppColors.foregroundColor);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

                  } catch (e) {
                    // print("$e");
                    showTopSnackBar(context, "Error confirming appointment", backgroundColor: AppColors.errorColor);
                    final pref = AppPreferences();
                    pref.lastDateAppointment = "";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }
                  
                  

                  // Navigator.popUntil(context, (route) => route.isFirst);
                  // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              ),
            )            
          ],
        ),
      ),
    );
  }

  void showTopSnackBar(BuildContext context, String message, {Color backgroundColor = Colors.green}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 35,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
    overlay.insert(overlayEntry);

    
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.specialityName,
    required this.selectedSlot,
  });

  final String doctorName;
  final String specialityName;
  final TimeSlot selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Doctor: ", style: TextStyle(fontSize: 18)),
              Expanded(
                child: Text(
                  doctorName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: null,
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text("Speciality: ", style: TextStyle(fontSize: 18)),
              Expanded(
                child: Text(
                  specialityName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: null,
                  softWrap: true,
                ),
              ),
            ],
          ),            
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Selected schedule: ', style: TextStyle(fontSize: 18)),
              Expanded(
                child: Text('${selectedSlot.startTime} - ${selectedSlot.endTime}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: null,
                  softWrap: true,
                ),
                
              ),
            ],
          ),
        ],
      ),
    );
  }
}
