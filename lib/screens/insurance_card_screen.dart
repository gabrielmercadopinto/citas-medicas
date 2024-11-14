// ignore_for_file: use_build_context_synchronously
import 'package:citas_medicas/components/costom_button.dart';
import 'package:citas_medicas/components/custom_drawer.dart';
// import 'package:citas_medicas/core/config/app_preferences.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:citas_medicas/providers/auth_provider.dart';

class InsuranceCardScreen extends StatelessWidget {
  static const String routeName = "insurance_card";
  const InsuranceCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Management')),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*CustomButton(
                    color: AppColors.primaryColor,
                    height: 40, 
                    text: "Create Insurance", 
                    onTap: () async {              
                      try {
                        final result = await provider.createInsurance();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                        final pref = AppPreferences();
                        pref.isInsuranceCreated = true;
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Credential already created previously, try to renew it')),
                        );
                      }                              
                    },
                  ),          
                  const SizedBox(height: 15,),*/
                  CustomButton(
                    color: AppColors.primaryColor,
                    height: 40, 
                    text: "Check Active Status", 
                    onTap: () async {
                      try {
                        final isActive = await provider.isInsuranceActive();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Insurance Active: $isActive')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Inactive')),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    color: AppColors.primaryColor,
                    height: 40,
                    text: "Renew Insurance",
                    onTap: () async {
                      try {
                        final result = await provider.renewInsurance();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Try Again')),
                        );
                      }
                    },
                  ),
                  /*const SizedBox(height: 15),
                  CustomButton(
                    color: AppColors.primaryColor,
                    height: 40,
                    text: "Cancel Insurance",
                    onTap: () async {
                      try {
                        final result = await provider.cancelInsurance();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Try Again')),
                        );
                      }
                    },
                  ),*/
                  const SizedBox(height: 15),
                  /*CustomButton(
                    color: AppColors.primaryColor,
                    height: 40,
                    text: "View Renewal History",
                    onTap: () async {
                      try {
                        final history = await provider.getRenewalHistory();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Renewal History: $history')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),*/
                  CustomButton(
                    color: AppColors.primaryColor,
                    height: 40,
                    text: "Check Remaining Time",
                    onTap: () async {
                      try {
                        final remainingSeconds = await provider.getRemainingTime();
                        final formattedTime = _formatDuration(remainingSeconds);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Remaining Time: $formattedTime')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ended Time')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (provider.isLoading)
            const Center(
              child: CircularProgressIndicator(strokeAlign: 20, strokeWidth: 6,),
            ),             
        ]
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
  final days = totalSeconds ~/ (24 * 3600);
  final hours = (totalSeconds % (24 * 3600)) ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  return '$days days $hours hours $minutes minutes $seconds seconds';
}

}