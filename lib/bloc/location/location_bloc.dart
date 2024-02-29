import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState()) {
    
    on<OnStartFollowingLocationEvent>((event, emit) => emit( state.copyWith( followingUser: true )));
    on<OnStopFollowingLocationEvent>((event, emit) => emit( state.copyWith( followingUser: false )));
    on<OnNewUserLocationEvent>((event, emit) { emit( state.copyWith(
        lastKnownLocation: event.newLocation,
        myLocationHistory: [ ...state.myLocationHistory, event.newLocation]
      ));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent( LatLng(position.latitude, position.longitude) ));
  }

  void startFollowingUser() {
    add(OnStartFollowingLocationEvent());
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add( OnNewUserLocationEvent( LatLng(position.latitude, position.longitude )));
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingLocationEvent());
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }

}
