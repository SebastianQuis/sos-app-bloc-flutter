import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sos_harold_app/bloc/users/users_bloc.dart';
import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class OpcionesPadreScreen extends StatelessWidget {
 static const nombre = 'OpcionesPadreScreen';

  const OpcionesPadreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            TitlePrincipal('Opciones de visualización'),
            
            MainButtons(),
            
          ],
        ),
      ),
    );
  }
}

class MainButtons extends StatelessWidget {
  const MainButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final userSelected = BlocProvider.of<UsersBloc>(context).userSelected;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        ButtonPrincipal(
          paddingVertical: 10,
          title: 'Notificación programada', 
          onPressed: () async {
            final phoneNumber = '51${userSelected!.celular}'; 
            final message = 'Buen día ${userSelected.nombres}, te escribimos de la clinica dental Ríos Dent';
            final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

            try {
              await launch(url, forceSafariVC: false);
            } catch (e) {
              throw 'No se pudo abrir WhatsApp.';
            }
          }
        ),
        
        
        ButtonPrincipal(
          paddingVertical: 10,
          title: 'Enviar mensaje', 
          onPressed: () async {
            String message = 'Hola.. Soy papá';
            String url = 'sms:${userSelected!.celular}?body=$message';
            try {
              await launch(url, forceSafariVC: false);
            } catch (e) {
              throw 'No se pudo abrir SMS.';
            }
          }
        ),
        
        ButtonPrincipal(
          color: Colors.redAccent,
          title: 'Finalizar', 
          onPressed: () {
            Navigator.pushReplacementNamed(context, UsuarioSeleccionaScreen.nombre);
          }
        ),

      ],
    );
  }
}