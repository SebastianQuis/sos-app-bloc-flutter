import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:sos_harold_app/bloc/auth/auth_bloc.dart';
import 'package:sos_harold_app/helpers/helpers.dart';
import 'package:sos_harold_app/providers/login_form_provider.dart';
import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class LoginScreen extends StatelessWidget {
  static const nombre = 'LoginScreen';
  const LoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              
              const LogoPrincipal(height: 300),
              
              ChangeNotifierProvider(
                create: (context) => LoginFormProvider(),
                child: const FormularioBody()
              ),
                
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioBody extends StatelessWidget {
  const FormularioBody({super.key});

  @override
  Widget build(BuildContext context) {

    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: loginFormProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
          
            InputForm(
              textInputType: TextInputType.emailAddress,
              hintText: 'example@gmail.com',
              suffixIcon: const Icon(Icons.alternate_email, color: Colors.black,),
              labelText: 'Usuario',
              onChanged: (value) => loginFormProvider.email = value,
              validator: (value) {
                String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
      
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Ingrese un correo valido';
              },
            ),
      
            const SizedBox(height: 10,),
            
            InputForm(
              hintText: '*********',
              obscureText: true,
              suffixIcon: const Icon(Icons.password, color: Colors.black,),
              labelText: 'Contraseña',
              onChanged: (value) => loginFormProvider.password = value,
              validator: (value) {
                return (value != null && value.length > 5)
                    ? null
                    : 'Ingrese una contraseña valida';
              },
            ),
      
            ButtonPrincipal(
              title: 'Ingresar', 
              onPressed: loginFormProvider.isLoading
                ? null
                : () async {
                  FocusScope.of(context).unfocus();
                  if (!loginFormProvider.isValidForm()) return;
                  loginFormProvider.isLoading = true;
      
                  await Future.delayed(const Duration(seconds: 1));
                  final String? token = await authBloc.login(loginFormProvider.email, loginFormProvider.password);

                  if (token == null) {
                    NotificacionService.showSnackBar('Bienvenido!!', Colors.green);
                    Navigator.pushReplacementNamed(context,  authBloc.typeUser == 'Apoderado' ? AgregarHijoScreen.nombre : SOSScreen.nombre);
                  } else {
                    mostrarAlerta(context, 'Verifica tus credenciales');
                    loginFormProvider.isLoading = false;
                  }
              },
            ),
      
            const SizedBox(height: 10,),
      
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RegistroUsuarioScreen.nombre),
              child: const Text('Regístrate aquí', style: TextStyle(fontSize: 18, color: Colors.black))
            ),   
      
            const SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}