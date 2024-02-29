import 'package:flutter/material.dart';

import 'package:sos_harold_app/screens/screens.dart';

class AppRoutes {

  static String initialRoute = UsuarioSeleccionaScreen.nombre;
  
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll( { RegistroHijoScreen.nombre      : ( _ ) => const RegistroHijoScreen() });
    appRoutes.addAll( { AgregarHijoScreen.nombre       : ( _ ) => const AgregarHijoScreen() });
    appRoutes.addAll( { LoginScreen.nombre             : ( _ ) => const LoginScreen()} );
    appRoutes.addAll( { OpcionesHijoScreen.nombre      : ( _ ) => const OpcionesHijoScreen()} );
    appRoutes.addAll( { OpcionesPadreScreen.nombre     : ( _ ) => const OpcionesPadreScreen()} );
    appRoutes.addAll( { RegistroHijoScreen.nombre      : ( _ ) => const RegistroHijoScreen()});
    appRoutes.addAll( { RegistroUsuarioScreen.nombre   : ( _ ) => const RegistroUsuarioScreen()});
    appRoutes.addAll( { SOSScreen.nombre               : ( _ ) => const SOSScreen()});
    appRoutes.addAll( { UsuarioSeleccionaScreen.nombre : ( _ ) => const UsuarioSeleccionaScreen()});
    appRoutes.addAll( { BlocStateMap.nombre            : ( _ ) => const BlocStateMap()});
    appRoutes.addAll( { AccesoGPSScreen.nombre         : ( _ ) => const AccesoGPSScreen()});
    appRoutes.addAll( { MapaScreen.nombre              : ( _ ) => const MapaScreen()});

    return appRoutes;
  }

}
