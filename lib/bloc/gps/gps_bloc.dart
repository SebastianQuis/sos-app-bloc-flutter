import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? serviceStreamSubscription;

  GpsBloc() : super(const GpsState( isGpsEnabled: false, isGpsPermissionApproved: false )) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      isGpsEnabled: event.isGpsEnabled,
      isGpsPermissionApproved: event.isGpsPermissionApproved))
    );

    _init();
  }

  Future<void> _init() async {
    final List<bool> gpsInitStatus = await Future.wait([
      _checkGPSStatus(),
      _isPermissionApproved(),
    ]); 

    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0], 
      isGpsPermissionApproved: gpsInitStatus[1],
    ));
  }
  
  Future<bool> _isPermissionApproved() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }
  
  Future<bool> _checkGPSStatus() async {
    final isGPSEnabled = await Geolocator.isLocationServiceEnabled();
    
    serviceStreamSubscription = Geolocator.getServiceStatusStream().listen((event) { 
      final isEnabled = (event.index == 1) ? true : false;
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled, 
        isGpsPermissionApproved: state.isGpsPermissionApproved,
      ));
     });
    
    return isGPSEnabled;
  }

  Future<void> askGPSAccess() async { 
    final status = await Permission.location.request();
    
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionApproved: true));
       break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionApproved: false));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    serviceStreamSubscription?.cancel();
    return super.close();
  }

}
