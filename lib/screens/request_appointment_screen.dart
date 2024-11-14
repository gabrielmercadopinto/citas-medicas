import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:citas_medicas/components/components.dart';
import 'package:citas_medicas/core/config/app_preferences.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:citas_medicas/screens/doctor_shedule_screen.dart';
import 'package:citas_medicas/screens/insurance_card_screen.dart';
import 'package:citas_medicas/providers/speciality_provider.dart';
import 'package:citas_medicas/providers/auth_provider.dart';

class RequestAppointmentScreen extends StatelessWidget {
  static const String routeName = "request_appointment";
  const RequestAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final specialityProvider = Provider.of<SpecialityProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final pref = AppPreferences();
    DateTime currentDate = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Specialities'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: pref.lastDateAppointment == today
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'You already made an appointment for today, please come back tomorrow',
                  style: TextStyle(
                      color: AppColors.foregroundColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : FutureBuilder<bool>(
              future: authProvider.isTheInsuranceActive(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError || !(snapshot.data ?? false)) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You do not have an active insurance.',
                          style: TextStyle(
                              color: AppColors.foregroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          height: 50,                          
                          color: AppColors.primaryColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InsuranceCardScreen(),
                              ),
                            );
                          },                          
                          text:'Renew Insurance',
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  );
                }

                return FutureBuilder(
                  future: specialityProvider.loadSpecialities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    return Consumer<SpecialityProvider>(
                      builder: (context, provider, child) {
                        if (provider.specialities.isEmpty) {
                          return const Center(child: Text('There are no specialities'));
                        }
                        return ListView.builder(
                          itemCount: provider.specialities.length,
                          itemBuilder: (context, index) {
                            final speciality = provider.specialities[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                    speciality.name[0].toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  speciality.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: AppColors.primaryColor,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorScheduleScreen(
                                        specialityId: speciality.id,
                                        dayOfWeek: DateTime.now().weekday,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
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
