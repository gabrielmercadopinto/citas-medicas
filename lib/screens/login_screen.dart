// ignore_for_file: use_build_context_synchronously

import 'package:citas_medicas/screens/screens.dart';
import 'package:citas_medicas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:citas_medicas/controllers/controllers.dart';
import 'package:citas_medicas/providers/providers.dart';
import 'package:citas_medicas/components/components.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 410,
                height: 410,
                child: Image.asset('assets/images/logo.png')
              ),
              ChangeNotifierProvider(
                create: (context) => LoginProvider(),
                child: const LoginForm()),
              TextButton(
                onPressed: (){}, 
                child: const Text('Olvidé mi contraseña', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline), )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Correo electónico',
              hintText: 'johndoe@gmail.com',
              suffixIcon: Icon(Icons.mail_outline)
            ),
            validator: (email) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(email ?? '')
                      ? null
                      : 'Correo no valido';
                },
            onChanged: (email) => loginForm.email = email,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            obscureText: loginForm.obscureText,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: IconButton(onPressed: (){
                loginForm.obscureText = !loginForm.obscureText;
              }, icon: loginForm.obscureText 
                        ? const Icon(Icons.visibility_off) 
                        : const Icon(Icons.visibility))
            ),
            validator: (password) {
                  return (password != null && password.length >= 8)
                      ? null
                      : 'Minimo 8 caracteres';
                },
            onChanged: (password) => loginForm.password = password,
          ),
        ),
        const SizedBox(height: 30),
        CustomButton(
          height: 50,
          color: loginForm.isLoading ? Colors.grey : AppColors.primaryColor, 
          text: loginForm.isLoading ? 'Cargando' : 'Ingresar',
          onTap: loginForm.isLoading
            ? null 
            : () async {
              FocusScope.of(context).unfocus();

              if (!loginForm.isValidForm()) return;
              
              loginForm.isLoading = true;

              bool success = await AuthController.login(loginForm.email, loginForm.password);

              loginForm.isLoading = false;

              if(success){
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
              }else{
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      icon: const Icon(
                        Icons.error,
                        size: 40,
                      ),
                      iconColor: Colors.red,
                      content: const Text(
                          'Inicio de sesión fallido. \nPor favor, verifica tus credenciales.'),
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
            },
        ),
      ],
    ));
  }
}