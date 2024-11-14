import 'package:citas_medicas/controllers/controllers.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthController controller;

  AuthProvider(this.controller);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> createInsurance() async {
    setLoading(true);
    try {
      return await controller.crearSeguro();
    } finally {
      setLoading(false);
    }
  }

  Future<bool> isInsuranceActive() async {
    setLoading(true);
    try {
      return await controller.esSeguroActivo();
    } finally {
      setLoading(false);
    }
  }

  Future<bool> isTheInsuranceActive() async {
    return await controller.esSeguroActivo();
  }

  Future<String> renewInsurance() async {
    setLoading(true);
    try {
      await controller.cancelarSeguro();
      return await controller.crearSeguro();
    } finally {
      setLoading(false);
    }
  }

  Future<String> cancelInsurance() async {
    setLoading(true);
    try {
      return await controller.cancelarSeguro();
    } finally {
      setLoading(false);
    }
  }

  Future<List<int>> getRenewalHistory() async {
    setLoading(true);
    try {
      return await controller.consultarHistorialRenovaciones();
    } finally {
      setLoading(false);
    }
  }

  Future<int> getRemainingTime() async {
    setLoading(true);
    try {
      final time = await controller.tiempoRestante();
      print(time);
      return time; 
    } finally {
      setLoading(false);
    }
  }

}
