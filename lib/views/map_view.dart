import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sos_harold_app/bloc/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  
  const MapView({
    super.key, 
    required this.initialLocation, 
    required this.polylines
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;

    CameraPosition initialCamerPosition = CameraPosition(
      target: initialLocation,
      zoom: 14,
    );
    
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: ( pointerMoveEvent ) => mapBloc.add(OnStopFollowUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCamerPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          onMapCreated: (controller) => mapBloc.add(
            OnMapInitializedEvent(controller)
          ), // para el movimiento del marcador en el mapa        
        ),
      ),
    );
  }
}