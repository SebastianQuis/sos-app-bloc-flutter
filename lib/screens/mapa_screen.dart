import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sos_harold_app/bloc/blocs.dart';
import 'package:sos_harold_app/views/map_view.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class MapaScreen extends StatefulWidget {
  static const nombre = 'MapaScreen';
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          
          if (locationState.lastKnownLocation == null) {
            return const Center(child: Text('Espere por favor...'));
          }
          
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              
              Map<String, Polyline> polylines = Map<String, Polyline>.from(mapState.polylines);
              if (!mapState.showRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [

                    MapView(
                      initialLocation: locationState.lastKnownLocation!, 
                      polylines: polylines.values.toSet(),
                    ),

                    const SearchBarCustom()

                  ],
                ),
              );
            },
          );

        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnShowRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),

    );
  }
}