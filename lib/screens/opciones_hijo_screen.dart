import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class OpcionesHijoScreen extends StatelessWidget {
  static const nombre = 'OpcionesHijoScreen';
  const OpcionesHijoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            TitlePrincipal('Seleccione el servicio de ayuda que necesita'),
            
            ButtonsBody(),
            
          ],
        ),
      ),
    );
  }
}

class ButtonsBody extends StatelessWidget {
  const ButtonsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ButtonPrincipal(
          title: 'Policía',
          paddingVertical: 10, 
          onPressed: () async {
            String url = 'tel:105';
            
            try {
              await launch(url, forceSafariVC: false);
            } catch (e) {
              throw 'No se pudo abrir llamada.';
            }
          }
        ),
        
        ButtonPrincipal(
          title: 'Serenazgo',
          paddingVertical: 10, 
          onPressed: () async {
            String url = 'tel:014115555';
            
            try {
              await launch(url, forceSafariVC: false);
            } catch (e) {
              throw 'No se pudo abrir llamada.';
            }
            
          }
        ),
        
        ButtonPrincipal(
          title: 'Bomberos',
          paddingVertical: 10, 
          onPressed: () async {
            String url = 'tel:116';
            try {
              await launch(url, forceSafariVC: false);
            } catch (e) {
              throw 'No se pudo abrir llamada.';
            }
          }
        ),
        
        ButtonPrincipal(
          title: 'Contacto familiar',
          paddingVertical: 10, 
          onPressed: () async {
            String url = 'tel:994884094';
            try {
              await launch(url, forceSafariVC: false);
            } catch (e) {
              throw 'No se pudo abrir llamada.';
            }

          }
        ),
        
        ButtonPrincipal(
          title: 'Inicio',
          color: Colors.redAccent, 
          onPressed: (){
            Navigator.pushReplacementNamed(context, SOSScreen.nombre);
          }
        ),

      ],
    );
  }
}