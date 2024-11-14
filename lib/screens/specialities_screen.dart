import 'package:citas_medicas/components/custom_drawer.dart';
import 'package:citas_medicas/providers/speciality_provider.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecialitiesScreen extends StatelessWidget {
  static const String routeName = "specialities";
  const SpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpecialityProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Specialities')),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: provider.loadSpecialities(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Consumer<SpecialityProvider>(
            builder: (context, provider, child) {
              if(provider.specialities.isEmpty){
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
                        backgroundColor: AppColors.foregroundColor,
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
                    ),
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
