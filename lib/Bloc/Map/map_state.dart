part of 'map_bloc.dart';

@immutable

class MapState {

  final bool mapReady;
  final bool drawRoute;
  final bool followLocation;

  final LatLng? centralLocation;

  //Polylines
  final Map<String, Polyline> polylines ;

  MapState({
    this.mapReady = false,
    this.drawRoute = false,
    this.followLocation = false,
    this.centralLocation,
    Map<String, Polyline>? polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool? mapReady,
    bool? drawRoute,
    bool? followLocation,
    LatLng? centralLocation,
    Map<String, Polyline>? polylines
  }) => new MapState(
    mapReady: mapReady ?? this.mapReady,
    drawRoute: drawRoute ?? this.drawRoute,
    polylines: polylines ?? this.polylines,
    followLocation: followLocation ?? this.followLocation,
    centralLocation: centralLocation ?? this.centralLocation,
  );

}
