import 'package:citas_medicas/controllers/doctor_shedule_controller.dart';
import 'package:citas_medicas/models/doctor_shedule_model.dart';
import 'package:flutter/material.dart';

class DoctorScheduleProvider with ChangeNotifier {
  final DoctorScheduleController controller;

  DoctorScheduleProvider(this.controller);

  List<DoctorSchedule> _schedules = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<DoctorSchedule> get schedules => _schedules;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSchedules(int dayOfWeek, String specialityId) async {
    _schedules = [];
    _isLoading = true;
    _errorMessage = null;

    try {
      _schedules = await controller.fetchDoctorSchedules(dayOfWeek, specialityId);
      print("Provider: $_schedules");
    } catch (error) {
      print("Provider Error al mapear");
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
