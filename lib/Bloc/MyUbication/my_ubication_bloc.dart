import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'my_ubication_event.dart';
part 'my_ubication_state.dart';

class MyUbicationBloc extends Bloc<MyUbicationEvent, MyUbicationState> {
  MyUbicationBloc() : super(MyUbicationState()){
    on<MyUbicationEvent>((event, emit) {
      if( event is onChangeUbication ){
        final newLocation = LatLng(event.ubication.latitude, event.ubication.longitude);
        emit(MyUbicationState(existsUbication: true, ubication: newLocation));
      }
    });
  }

  StreamSubscription<Position>? _positionSubscription;

  void startTracking() {
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );
    this._positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(onChangeUbication(newLocation));
    });
  }

  void cancelTracking() {
    this._positionSubscription?.cancel();
  }

}
