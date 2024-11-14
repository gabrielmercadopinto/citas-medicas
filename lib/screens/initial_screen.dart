import 'package:citas_medicas/screens/screens.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:citas_medicas/components/components.dart';

class InitialScreen extends StatelessWidget {
  static const String routeName = "initial";
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              color: AppColors.primaryColor, 
              height: 50,
              text: 'Iniciar Session',             
              fontWeight: FontWeight.bold,
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}