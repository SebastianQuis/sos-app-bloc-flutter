part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent{
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}

class OnStartFollowUserEvent extends MapEvent {}
class OnStopFollowUserEvent extends MapEvent {}

class UpdateUserPolylinesEvent extends MapEvent{
  final List<LatLng> userLocations;
  const UpdateUserPolylinesEvent(this.userLocations);
}

class OnToggleShowRouteEvent extends MapEvent{}

