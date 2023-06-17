import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:meta/meta.dart';

import 'package:healing/Themes/PrimaryMapTheme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<MapEvent>((event, emit) {
      if( event is OnMapReady ){
        emit(MapState(mapReady: true));
      }
      if( event is OnLocationUpdate ){
        _onLocationUpdate(event);
      }
      if( event is OnDrawRoute ){
        _onDrawRoute(event);
      }
      if( event is OnFollowLocation ){
        _onFollowLocation(event);
      }
      if( event is OnDrawWeRoute ){
        _onDrawWeRoute(event);
      }
      if( event is OnMoveMap ){
        emit(MapState(
          followLocation: state.followLocation,
          mapReady: state.mapReady,
          drawRoute: state.drawRoute,
          polylines: state.polylines,
          centralLocation: event.centerMap,
        ));
      }
    });
  }
  // controlator of the map
  GoogleMapController? _googleMapController;

  // polylines my route
  Polyline _myRoute = Polyline(
    polylineId: PolylineId('myRoute'),
    color: Colors.transparent,
    width: 4
  );

  // polylines we route
  Polyline _weRoute = Polyline(
    polylineId: PolylineId('weRoute'),
    color: primaryColor,
    width: 4,
  );

  void initMap(GoogleMapController controller) {
    if(!state.mapReady) {
      _googleMapController = controller;
      _googleMapController?.setMapStyle(jsonEncode(PRIMARYMAPTHEME));
      add(OnMapReady());
    }
  }

  void moveCamera(LatLng myUbication) {
    final cameraUpdate = CameraUpdate.newLatLng(myUbication);
    _googleMapController?.animateCamera(cameraUpdate);
  }

  _onLocationUpdate(OnLocationUpdate event) {
    if( state.followLocation ){
      moveCamera(event.ubication);
    }
    final List<LatLng> points = [..._myRoute.points, event.ubication];
    _myRoute = _myRoute.copyWith(
      pointsParam: points,
    );
    final currentPolylines = state.polylines;
    currentPolylines['myRoute'] = _myRoute;
    return emit(MapState(
      followLocation: state.followLocation,
      mapReady: state.mapReady,
      drawRoute: state.drawRoute,
      polylines: currentPolylines
    ));
  }

  _onDrawRoute(OnDrawRoute event) {
    if( !state.drawRoute ) {
      _myRoute = _myRoute.copyWith(colorParam: primaryColor);
    } else {
      _myRoute = _myRoute.copyWith(colorParam: Colors.transparent);
    }
    final currentPolylines = state.polylines;
    currentPolylines['myRoute'] = _myRoute;
    return emit(MapState(
      followLocation: state.followLocation,
      mapReady: state.mapReady,
      drawRoute: !state.drawRoute,
      polylines: currentPolylines,
    ));
  }

  _onFollowLocation(OnFollowLocation event) {
    if( !state.followLocation ) {
      moveCamera(_myRoute.points[_myRoute.points.length - 1 ]);
    }
    return emit(MapState(
      followLocation: !state.followLocation,
      mapReady: state.mapReady,
      drawRoute: state.drawRoute,
      polylines: state.polylines
    ));
  }

  _onDrawWeRoute(OnDrawWeRoute event) {
    _weRoute = _weRoute.copyWith(
      pointsParam: event.coords,
    );
    final currentPolylines = state.polylines;
    currentPolylines['weRoute'] = _weRoute;

    return emit(MapState(
        followLocation: state.followLocation,
        mapReady: state.mapReady,
        drawRoute: state.drawRoute,
        polylines: currentPolylines
    ));
  }
}
