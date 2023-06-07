import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healing/Bloc/Map/map_bloc.dart';
import 'package:healing/Bloc/MyUbication/my_ubication_bloc.dart';
import 'package:healing/HttpProtocol/Navigation.dart';
import 'package:healing/Model/TrafficResponse.dart';
import 'package:healing/Widgets/ButtonBase.dart';
import 'package:healing/Widgets/ButtonFollow.dart';
import 'package:healing/Widgets/ButtonLocation.dart';
import 'package:healing/Widgets/ButtonMyRoute.dart';
import 'package:healing/Widgets/ProgressDialog.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage>{
  @override
  void initState() {
    BlocProvider.of<MyUbicationBloc>(context).startTracking();
    super.initState();
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
          ButtonLocation(),
          ButtonFollow(),
          ButtonMyRoute(),
          BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (context, state) =>  ButtonBase("ruta", () => marcarTrayectoria(state)),
          ),
         
        ],
      ),
    );
  }

  Widget createMap(MyUbicationState state) {
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

    var polylineData = await Navigation.getRoute(state.ubication!, LatLng(4.712557, -74.11411));
    final trafficResponse = trafficResponseFromJson(polylineData);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;

    List<PointLatLng> result = polylinePoints.decodePolyline(geometry);
    final List<LatLng> coords = result.map((e) => LatLng(e.latitude, e.longitude)).toList();

    mapBloc.add(OnDrawWeRoute(coords, duration, distance));

  }

}