part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent {}

class OnDrawRoute extends MapEvent {}

class OnFollowLocation extends MapEvent {}

class OnDrawWeRoute extends MapEvent {
  final List<LatLng> coords;
  final double duration;
  final double distance;

  OnDrawWeRoute(this.coords, this.duration, this.distance);
}

class OnMoveMap extends MapEvent {
  final LatLng centerMap;

  OnMoveMap(this.centerMap);
}

class OnLocationUpdate extends MapEvent {
  final LatLng ubication;

  OnLocationUpdate(this.ubication);
}

