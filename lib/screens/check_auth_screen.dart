import 'package:flutter/material.dart';
import 'package:citas_medicas/controllers/auth_controller.dart';
import 'package:citas_medicas/screens/screens.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String routeName = 'checking';
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:  AuthController.readToken(),
        builder: (context, snapshot) {

          if( !snapshot.hasData ) {
            return const CircularProgressIndicator();
          }

          if( snapshot.data == ''){
            Future.microtask(() {
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_, __, ___) => const InitialScreen(),
                transitionDuration: const Duration(seconds: 0),
              ));
            });
          }else{
            Future.microtask(() {
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_, __, ___) => const HomeScreen(),
                transitionDuration: const Duration(seconds: 0),
              ));
            });
          }
          return Container();
        },
      ),
    );
  }
}
