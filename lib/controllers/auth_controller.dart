// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:citas_medicas/core/config/app_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:citas_medicas/utils/environment.dart';

class AuthController {
  static const baseUrl = Environment.apiURL;
  static const blockchainURL = Environment.blockchainURL;  
  static const duracion = "100";

  static Future<bool> login(String email, String password) async {
    try {
      final pref = AppPreferences();
      pref.clearPreferences();
      /*final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);

        print('Inicio de sesión exitoso. Token: ${jsonData['access_token']}');
        print("User ID: ${jsonData['user_id']}");

        await saveInfo(
            jsonData['user_id'], jsonData['access_token'], jsonData['email']);
        return true;
      } else {
        print('Error al iniciar sesión');
        return false;
      }*/
      sleep(const Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> saveInfo(
      int userId, String token, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
    prefs.setString('token', token);
    prefs.setString('email', email);
  }

  static Future<bool> logout() async {
    try {
      /*final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print('Bearer: $token');

      final url = Uri.parse('$baseUrl/logout');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        print('Cierre de sesión exitoso');
        await prefs.clear();
        return true;
      } else {
        print('Error al cerrar sesión');
        return false;
      }*/
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> crearSeguro() async {
    final pref = AppPreferences();
    pref.userId = 1;
    final userId = pref.userId;
    print("Llego al Controlador");
    final url = Uri.parse('$blockchainURL/crearSeguro');
    try {
      print("inicia la peticion");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
        'id': userId.toString(),
        'duracion': duracion,
        }),
      );
      print("termina la peticion");
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.body);
        return "Insurance created";
      } else {
        throw Exception('Failed to create insurance: ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error creating insurance: $e');
    }
  }

  Future<bool> esSeguroActivo() async {
    final pref = AppPreferences();
    pref.userId = 1;
    final userId = pref.userId;
    final url = Uri.parse('$blockchainURL/esSeguroActivo/$userId');
    try {
      print("inicia la peticion");
      final response = await http.get(url);
      print("finaliza la peticion");
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        print(data['activo']);
        return data['activo'];
      } else {
        throw Exception('Failed to check insurance status: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error checking insurance status: $e');
    }
  }

  Future<String> renovarSeguro() async {
    final pref = AppPreferences();
    pref.userId = 1;
    final userId = pref.userId;
    final url = Uri.parse('$blockchainURL/renovarSeguro');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': userId, 
          'duracion': duracion
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return "Seguro renovado";
      } else {
        throw Exception('Failed to renew insurance: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error renewing insurance: $e');
    }
  }

  Future<String> cancelarSeguro() async {
    final pref = AppPreferences();
    pref.userId = 1;
    final userId = pref.userId;
    final url = Uri.parse('$blockchainURL/cancelarSeguro');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id':userId
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return "Seguro cancelado";
      } else {
        throw Exception('Failed to cancel insurance: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error canceling insurance: $e');
    }
  }

  Future<List<int>> consultarHistorialRenovaciones() async {
    final pref = AppPreferences();
    pref.userId = 1;
    final userId = pref.userId;
    final url = Uri.parse('$blockchainURL/consultarHistorialRenovaciones/$userId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<int>.from(data['historial']);
      } else {
        throw Exception('Failed to fetch renewal history: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching renewal history: $e');
    }
  }

  Future<int> tiempoRestante() async {
    final pref = AppPreferences();
    pref.userId = 1;
    final userId = pref.userId;
    final url = Uri.parse('$blockchainURL/tiempoRestante/$userId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return int.parse(data['tiempoRestante']);
      } else {
        throw Exception('Failed to fetch remaining time: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching remaining time: $e');
    }
  }
  
}
