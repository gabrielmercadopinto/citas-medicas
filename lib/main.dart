import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:citas_medicas/core/config/app_preferences.dart';
import 'package:citas_medicas/core/graphql/graphql_client.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';

import 'package:citas_medicas/controllers/controllers.dart';
import 'providers/providers.dart';
import 'package:citas_medicas/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().initPrefs();  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SpecialityProvider(SpecialityController(GraphQLConfig.getClient()))
        ),  
        ChangeNotifierProvider(
          create: (_) => DoctorScheduleProvider(DoctorScheduleController(GraphQLConfig.getClient()))
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentProvider(AppointmentController(GraphQLConfig.getClient()))
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthController()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clinica',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: AppColors.primaryColor, foregroundColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        initialRoute: InitialScreen.routeName,
        routes: {
          CheckAuthScreen.routeName:(context) => const CheckAuthScreen(),
        
          LoginScreen.routeName:(context) => const LoginScreen(),
        
          InitialScreen.routeName:(context) => const InitialScreen(),
          HomeScreen.routeName:(context) => const HomeScreen(),
        
          InsuranceCardScreen.routeName:(context) => const InsuranceCardScreen(),
          RequestAppointmentScreen.routeName:(context) => const RequestAppointmentScreen(),
          AppointmentHistoryScreen.routeName:(context) => const AppointmentHistoryScreen()
        },
      ),
    );
  }
}