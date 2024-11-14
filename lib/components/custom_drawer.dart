import 'package:citas_medicas/screens/appointment_history_screen.dart';
import 'package:citas_medicas/screens/request_appointment_screen.dart';
import 'package:flutter/material.dart';

import 'package:citas_medicas/controllers/controllers.dart';
import 'package:citas_medicas/screens/screens.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero, //const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/header.jpg'),
                      fit: BoxFit.cover)),
            )
          ),  
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Insurance card'),
            leading: const Icon(Icons.contacts_rounded),
            onTap: () {
              Navigator.pushReplacementNamed(context, InsuranceCardScreen.routeName);
            },
          ),        
          const Divider(),
          ListTile(
            title: const Text('Request appointment'),
            leading: const Icon(Icons.calendar_month),
            onTap: () {
              Navigator.pushReplacementNamed(context, RequestAppointmentScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Appoinments'),
            leading: const Icon(Icons.history),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppointmentHistoryScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () =>  _handleLogout(context),
          ),
          const Divider(),
          ListTile(
            title: const Text('Version Information'),
            leading: const Icon(Icons.info_outlined),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Clinica',
                applicationVersion: 'Version: 1.0',
              );
            },
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.error,
            size: 35,
          ),
          iconColor: Colors.red,
          content: const Text(
            'Algo salió mal, por favor intentalo de nuevo.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleLogout(BuildContext context) async {
    bool success = await AuthController.logout();
    if (success && context.mounted) {    
      Navigator.pushReplacementNamed(context, InitialScreen.routeName);      
    } else {
      if (context.mounted) {
        _showErrorDialog(context);
      }
    }
  }

}
