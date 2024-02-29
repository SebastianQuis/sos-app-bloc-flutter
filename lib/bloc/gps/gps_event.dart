part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}


class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionApproved;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled, 
    required this.isGpsPermissionApproved
  });
}
