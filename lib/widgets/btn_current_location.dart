import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/blocs.dart';
import 'package:sos_harold_app/ui/custom_snackbar.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {

    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: CircleAvatar(
        maxRadius: 22,
        backgroundColor: Colors.grey[400],
        child: IconButton(
          onPressed: (){
            final userLocation = locationBloc.state.lastKnownLocation;

            if ( userLocation == null ) {
              final snack = CustomSnackbar(message: 'Ubicación desconocida!!');
              ScaffoldMessenger.of(context).showSnackBar(snack);
            }
            
            mapBloc.moveCamera(userLocation!);
          }, 
          icon: const Icon(Icons.location_on, color: Colors.black87, size: 25,)
        ),
      ),
    );
  }
}

