import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:citas_medicas/components/custom_drawer.dart';
import 'package:citas_medicas/components/components.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [          
          const Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/home.png'),
          ),
          Text(
            "Welcome!",
            style: GoogleFonts.dmSerifDisplay(fontSize: 30, color: AppColors.foregroundColor),
          ),
          Text(
            "Now you can schedule your medical appointment from the comfort of your home, quickly and easily.",
            style: GoogleFonts.dmSerifDisplay(fontSize: 22, letterSpacing: 1.5, color: AppColors.foregroundColor),
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }
}
