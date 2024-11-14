import 'package:citas_medicas/components/custom_drawer.dart';
import 'package:citas_medicas/core/config/app_helpers.dart';
import 'package:citas_medicas/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  static const String routeName = "appointment_history";

  const AppointmentHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Appointment History')),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: provider.loadAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Consumer<AppointmentProvider>(
            builder: (context, provider, child) {
              final appointments = provider.appointments;

              if (appointments.isEmpty) {
                return const Center(child: Text('No appointments found.'));
              }

              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return AppointmentCard(appointment: appointment);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final schedule = AppHelper.calculateSlot(appointment.doctorShedule.startTime, appointment.doctorShedule.slotDuration, appointment.slotNumber);
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${appointment.appointmentDate.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Doctor: ${appointment.doctorShedule.doctor.user.fullName}'),
            Text('Speciality: ${appointment.doctorShedule.speciality.name}'),
            Text('Consulting Room: ${appointment.doctorShedule.consultingRoom.roomName}'),
            Text('Location: ${appointment.doctorShedule.consultingRoom.roomLocation}'),
            // Text('Slot Selected: ${appointment.slotNumber}'),
            // Text('Doctor´s Schedule: ${appointment.doctorShedule.startTime} - ${appointment.doctorShedule.endTime}'),
            Text('Selected Schedule: ${schedule.startTime} - ${schedule.endTime}'),
            Text('Appointment Duration: ${appointment.doctorShedule.slotDuration} mins'),
            Text('Status: ${appointment.status}'),
          ],
        ),
      ),
    );
  }
}