import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sos_harold_app/bloc/location/location_bloc.dart';
import 'package:sos_harold_app/theme/uber_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? streamSubscription; 
  
  MapBloc({required this.locationBloc}) : super(const MapState()) {
  
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowUserEvent>(_onStartFollowingUser);
    on<OnStopFollowUserEvent>((event, emit) => emit( state.copyWith(
      isFollowingUser: false,
    )));
    on<UpdateUserPolylinesEvent>(_onCreatePolylinePoint);
    on<OnToggleShowRouteEvent>((event, emit) => emit( state.copyWith(
      showRoute: !state.showRoute
    )));
    
    _followUserCamera();
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberTheme));
    emit( state.copyWith( isMapInitialized: true, ));
  }

  void _onStartFollowingUser(OnStartFollowUserEvent event, Emitter<MapState> emit) {
    emit( state.copyWith( isFollowingUser: true ));
    if(locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _followUserCamera() {
    streamSubscription = locationBloc.stream.listen(( locationState ) {
      if( locationState.lastKnownLocation != null) {
        add(UpdateUserPolylinesEvent(locationState.myLocationHistory));
      }
      
      if ( !state.isFollowingUser) return;
      if ( locationState.lastKnownLocation == null) return;
      moveCamera( locationState.lastKnownLocation! );
    });
  }

  void _onCreatePolylinePoint(UpdateUserPolylinesEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.indigo,
      width: 3,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;
    emit(state.copyWith(polylines: currentPolylines));
  }

  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation); 
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
  
}
