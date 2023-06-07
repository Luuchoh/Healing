import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing/Bloc/Map/map_bloc.dart';
import 'package:healing/Bloc/MyUbication/my_ubication_bloc.dart';

import 'package:healing/Values/ColorsApp.dart';

class ButtonLocation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);
    final myUbicationBloc = BlocProvider.of<MyUbicationBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location_outlined,
            color: primaryColor,
          ),
          onPressed: () {
            final myUbication =  myUbicationBloc.state.ubication;
            mapBloc.moveCamera(myUbication!);
          },
        ),
      ),
    );
  }

}