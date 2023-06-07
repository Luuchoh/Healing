import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing/Bloc/Map/map_bloc.dart';

import 'package:healing/Values/ColorsApp.dart';

class ButtonMyRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: primaryColor,
          ),
          onPressed: () {
            mapBloc.add(OnDrawRoute());
          },
        ),
      ),
    );
  }

}