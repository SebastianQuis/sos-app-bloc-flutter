import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/auth/auth_bloc.dart';
import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';


class SOSScreen extends StatelessWidget {
  static const nombre = 'SOSScreen';
  const SOSScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userLogged = BlocProvider.of<AuthBloc>(context).state.userLogged;
    final nombre = userLogged!.email.split('@')[0];


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            TitlePrincipal('Hola $nombre'),

            SizedBox(height: size.height * 0.3,),

            ButtonPrincipal(
              title: 'Cerrar sesión',
              onPressed: () => Navigator.pushReplacementNamed(context, UsuarioSeleccionaScreen.nombre),
              color: Colors.red,
            ),
            
            ButtonPrincipal(
              title: 'SOS', 
              onPressed: () {
                Navigator.pushNamed(context, OpcionesHijoScreen.nombre);
              }
            ),
            
          ],
        ),
      ),
    );
  }
}