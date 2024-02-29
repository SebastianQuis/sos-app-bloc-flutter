import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/blocs.dart';
import 'package:sos_harold_app/screens/screens.dart';


class BlocStateMap extends StatelessWidget {
  static const nombre = 'BlocStateMap';
  const BlocStateMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => GpsBloc()),
        BlocProvider( create: (context) => LocationBloc()),
        BlocProvider( create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context) ) ),
      ],
      child: const LoadingScreen(),
    );
  }
}


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllApproved
            ? const MapaScreen()
            : const AccesoGPSScreen();
        },
      )
    );
  }
}