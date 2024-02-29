part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionApproved;

  const GpsState({required this.isGpsEnabled, required this.isGpsPermissionApproved});

  bool get isAllApproved => isGpsEnabled && isGpsPermissionApproved;

  GpsState copyWith({ bool? isGpsEnabled, bool? isGpsPermissionApproved }) {
    return GpsState(
      isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
      isGpsPermissionApproved: isGpsPermissionApproved ?? this.isGpsPermissionApproved
    );
  }

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionApproved];

  @override
  String toString() => '{isGpsEnabled: $isGpsEnabled, isGpsPermissionAproved: $isGpsPermissionApproved}';
}

