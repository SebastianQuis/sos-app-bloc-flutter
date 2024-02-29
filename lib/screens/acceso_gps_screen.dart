import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/blocs.dart';


class AccesoGPSScreen extends StatelessWidget {
  static const nombre = 'AccesoGPSScreen';
  const AccesoGPSScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return (!state.isGpsEnabled)
              ? _HabilitarGPS()
              : _BotonAccesoGPS();
          },
        ) 
      ),
    );
  }
}


class _HabilitarGPS extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe habilitar GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    );
  }
}


class _BotonAccesoGPS extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        const Text(
          'Debe aceptar el acceso al GPS',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 10,),

        MaterialButton(
          splashColor: Colors.transparent,
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGPSAccess();
          },
          color: Colors.indigo,
          elevation: 0, 
          child: const Text('Solicitar Acceso', style: TextStyle(color: Colors.white),),
        ),

      ],
    );
  }
}