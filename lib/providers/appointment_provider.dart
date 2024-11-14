import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../controllers/appointment_controller.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentController controller;
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  AppointmentProvider(this.controller);

  Future<void> loadAppointments() async {
    try {
      _appointments = await controller.fetchAppointments();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }
}
