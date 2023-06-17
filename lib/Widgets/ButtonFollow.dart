import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing/Bloc/Map/map_bloc.dart';

import 'package:healing/Values/ColorsApp.dart';

class ButtonFollow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return BlocBuilder<MapBloc, MapState>(
      builder: (_, state) => _createButton(context, state)
    );
  }

  Widget _createButton(BuildContext context,MapState state) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: Icon(
              state.followLocation ? Icons.directions_run : Icons.accessibility_new,
              color: primaryColor,
            ),
            onPressed: () {
              mapBloc.add(OnFollowLocation());
            },
          ),
        ),
      );
  }

}