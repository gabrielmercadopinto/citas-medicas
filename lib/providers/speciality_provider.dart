import 'package:citas_medicas/controllers/speciality_controller.dart';
import 'package:citas_medicas/models/speciality_model.dart';
import 'package:flutter/material.dart';

class SpecialityProvider with ChangeNotifier {
  final SpecialityController controller;

  SpecialityProvider(this.controller);

  List<Speciality> _specialities = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Speciality> get specialities => _specialities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadSpecialities() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      _specialities = await controller.fetchSpecialities();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
