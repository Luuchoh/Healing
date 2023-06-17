import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healing/Bloc/Map/map_bloc.dart';
import 'package:healing/Bloc/MyUbication/my_ubication_bloc.dart';
import 'package:healing/DataBase/Firebase.dart';
import 'package:healing/Helpers/helpers.dart';
import 'package:healing/HttpProtocol/Navigation.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/TrafficResponse.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/HomePage.dart';
import 'package:healing/Widgets/ButtonChat.dart';
import 'package:healing/Widgets/ButtonFollow.dart';
import 'package:healing/Widgets/ButtonLocation.dart';
import 'package:healing/Widgets/ButtonTerminateServices.dart';
import 'package:healing/Widgets/ProgressDialog.dart';

class MapPage extends StatefulWidget {

  User user, peer;
  Count count;

  MapPage(this.user, this.peer, this.count);

  @override
  State<StatefulWidget> createState() => MapPageState(user, peer, count);
}

class MapPageState extends State<MapPage>{

  User user, peer;
  Count count;

  MapPageState(this.user, this.peer, this.count);


  StreamSubscription<DatabaseEvent>? onChangeSubs;

  @override
  void initState() {
    BlocProvider.of<MyUbicationBloc>(context).startTracking();
    onChangeSubs = Firebase.tableUser
        .orderByKey()
        .equalTo(peer.id)
        .onChildChanged
        .listen(onEntryChange);
    if(user.rol == 'Médico' && user.viewMap == 0 ){
      user.viewMap = 0;
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, HomePage(user, count)));
    }
    super.initState();
  }

  onEntryChange(DatabaseEvent event) async {
    User newUser = User.toUser(event.snapshot);
    if (mounted)
      setState(() {
        peer = newUser;
      });
    if(newUser.viewMap == 0) {
      user.viewMap = 0;
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, HomePage(user, count)));
    }
  }

  @override
  void dispose() {
    BlocProvider.of<MyUbicationBloc>(context).cancelTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MyUbicationBloc, MyUbicationState>(
          builder: (context, state) => createMap(state),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonChat(user, peer, count),
          ButtonLocation(),
          ButtonFollow(),
          (user.rol == 'Paciente') ? ButtonTerminateServices(user, peer, count) : SizedBox.shrink(),
          // ButtonMyRoute(),
        ],
      ),
    );
  }

  Widget createMap(MyUbicationState state) {
    marcarTrayectoria(state);

    user.latitude = state.ubication?.latitude ?? 4.7037316 ;
    user.longitude = state.ubication?.longitude ?? -74.2110208;
    user.updateLocation();

    if( !state.existsUbication ) return ProgressDialog();

    final mapBloc =  BlocProvider.of<MapBloc>(context);
    final initCameraPosition = CameraPosition(
      target: state.ubication ?? LatLng(37.42796133580664, -122.085749655962),
      zoom: 15,
    );
    
    mapBloc.add(OnLocationUpdate(state.ubication!));

    return BlocBuilder<MapBloc, MapState>(builder: (context, _) {
      return GoogleMap(
        initialCameraPosition: initCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        polylines: mapBloc.state.polylines.values.toSet(),
        onMapCreated: mapBloc.initMap,
        onCameraMove: (initCameraPosition) {
          mapBloc.add(OnMoveMap(initCameraPosition.target));
        },
      );
    });
  }
  
  marcarTrayectoria(MyUbicationState state) async{
    PolylinePoints polylinePoints = PolylinePoints();
    final mapBloc =  BlocProvider.of<MapBloc>(context);

    var polylineData = await Navigation.getRoute(state.ubication ?? LatLng(4.7037316, -74.2110208), LatLng(peer.latitude, peer.longitude));
    final trafficResponse = trafficResponseFromJson(polylineData);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;

    List<PointLatLng> result = polylinePoints.decodePolyline(geometry);
    final List<LatLng> coords = result.map((e) => LatLng(e.latitude, e.longitude)).toList();

    mapBloc.add(OnDrawWeRoute(coords, duration, distance));

  }

}