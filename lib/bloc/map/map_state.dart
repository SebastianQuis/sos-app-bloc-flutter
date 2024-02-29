part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showRoute;

  final Map<String, Polyline> polylines;
  
  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = true,
    this.showRoute = true,
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ?? const {};

  MapState copyWith({bool? isMapInitialized, bool? isFollowingUser, bool? showRoute, Map<String, Polyline>? polylines}) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showRoute: showRoute ?? this.showRoute,
    polylines: polylines ?? this.polylines,
  );
  
  @override
  List<Object> get props => [ isMapInitialized, isFollowingUser, showRoute, polylines ];
}


