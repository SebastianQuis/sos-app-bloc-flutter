import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:sos_harold_app/bloc/blocs.dart';
import 'package:sos_harold_app/helpers/helpers.dart';
import 'package:sos_harold_app/models/models.dart';
import 'package:sos_harold_app/providers/login_form_provider.dart';
import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class RegistroUsuarioScreen extends StatelessWidget {
  static const nombre = 'RegistroUsuarioScreen';

  const RegistroUsuarioScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
        
            const TitlePrincipal('Registro'),
            
            Expanded(
              child: SingleChildScrollView(
                child: ChangeNotifierProvider(
                  create: (context) => LoginFormProvider(),
                  child: _FormBody()
                )
              )
            ),
            
          ],
        ),
      ),
    );
  }
}


class _FormBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usersBloc = BlocProvider.of<UsersBloc>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: loginFormProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
          
            InputForm(
              labelText: 'Nombre',
              suffixIcon: const Icon(Icons.person_outline, color: Colors.black,),
              onChanged: (value) => loginFormProvider.nombres = value,
              validator: (value) {
                return (value != null && value.length > 3)
                  ? null
                  : 'Mínimo 3 caracteres';
              },
            ),
        
            const SizedBox(height: 10,),
            
            InputForm(
              labelText: 'Apellidos',
              suffixIcon: const Icon(Icons.person_add_alt, color: Colors.black,),
              onChanged: (value) => loginFormProvider.apellidos = value,
              validator: (value) {
                return (value != null && value.length > 3)
                  ? null
                  : 'Mínimo 3 caracteres';
              },
            ),
            
            const SizedBox(height: 10,),
            
            InputForm(
              labelText: 'Edad',
              textInputType: TextInputType.number,
              suffixIcon: const Icon(Icons.add_circle_outline_rounded, color: Colors.black,),
              onChanged: (value) => loginFormProvider.edad = value,
              validator: (value) {
                return (value != null && value.length < 3)
                  ? null
                  : 'Mínimo 2 digitos';
              },
            ),
            const SizedBox(height: 10,),
            
            InputForm(
              labelText: 'Celular',
              textInputType: TextInputType.number,
              suffixIcon: const Icon(Icons.phone_outlined, color: Colors.black,),
              onChanged: (value) => loginFormProvider.celular = value,
              validator: (value) {
                return (value != null && value.length == 9)
                  ? null
                  : '9 digitos';
              },
            ),
            
            const SizedBox(height: 10,),
            
            InputForm(
              labelText: 'DNI',
              textInputType: TextInputType.number,
              suffixIcon: const Icon(Icons.format_indent_increase_outlined, color: Colors.black,),
              onChanged: (value) => loginFormProvider.dni = value,
              validator: (value) {
                return (value != null && value.length == 8)
                  ? null
                  : '8 digitos';
              },
            ),
            
            InputForm(
              labelText: 'Correo electrónico',
              textInputType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.email_outlined, color: Colors.black,),
              onChanged: (value) => loginFormProvider.email = value,
              validator: (value) {
                String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
      
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'example@gmail.com';
              },
            ),
            
            InputForm(
              labelText: 'Contraseña',
              obscureText: true,
              suffixIcon: const Icon(Icons.key_outlined, color: Colors.black,),
              onChanged: (value) => loginFormProvider.password = value,
              validator: (value) {
                return (value != null && value.length > 5)
                    ? null
                    : 'Mínimo 5 caracteres';
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

                  final newUser = Usuario(
                    apellidos: loginFormProvider.apellidos!, 
                    celular: int.parse(loginFormProvider.celular!),
                    dni: int.parse(loginFormProvider.dni!), 
                    edad: int.parse(loginFormProvider.edad!), 
                    email: loginFormProvider.email,
                    nombres: loginFormProvider.nombres!, 
                    password: loginFormProvider.password,
                  );

                  final String? token = await authBloc.createUser(loginFormProvider.email, loginFormProvider.password);
                  await usersBloc.createUser(newUser);

                  if (token == null) {
                    NotificacionService.showSnackBar('Registro correcto', Colors.black45);
                    Navigator.pushReplacementNamed(context, LoginScreen.nombre);
                  } else {
                    mostrarAlerta(context, 'Registro incorrecto!');
                    loginFormProvider.isLoading = false;
                  }                
                },
            ),
          
          ],
        ),
      ),
    );
  }
}