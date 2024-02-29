import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/auth/auth_bloc.dart';
import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class UsuarioSeleccionaScreen extends StatelessWidget {
  static const nombre = 'UsuarioSeleccionaScreen';
  const UsuarioSeleccionaScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              
              LogoPrincipal(height: 300),
        
              _ButtonsBody(),
        
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonsBody extends StatelessWidget {
  const _ButtonsBody();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Container(
      padding: const EdgeInsets.only( top: 20),
      child: Column(
        children: [
          
          ButtonPrincipal(
            title: 'Apoderado',
            onPressed: () {
              authBloc.typeUser = 'Apoderado';
              Navigator.pushNamed(context, LoginScreen.nombre);
            },
          ),
          
          ButtonPrincipal(
            title: 'Hijo',
            onPressed: () {
              authBloc.typeUser = 'Hijo';
              Navigator.pushNamed(context, LoginScreen.nombre);
            },
          ),

        ],
      ),
    );
  }
}