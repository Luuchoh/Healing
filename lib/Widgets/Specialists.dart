import 'package:flutter/material.dart';
import 'package:healing/Helpers/helpers.dart';
import 'package:healing/Model/User.dart';
import 'package:healing/Pages/MapPage.dart';
import 'package:healing/Widgets/CardSpecialist.dart';
import 'package:healing/Widgets/TextBase.dart';

class Specialists extends StatelessWidget {
  User user;
  List<User> specialist;

  Specialists(this.user, this.specialist);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: TextBase(
              'Especialistas',
              align: TextAlign.start,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 115,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: specialist.length,
                itemBuilder: (context, index) {
                  return buildItem(context, specialist[index]);
                }),
          )
        ],
      ),
    );
  }

  buildItem(BuildContext context, User peer) {
    return (peer == null || user.id == peer.id || peer.isActive == 0 || peer.rol == 'Paciente')
        ? SizedBox.shrink()
        : (user.rol != 'Médico')
          ? GestureDetector(
            onTap: () {
              goToMap(context, peer, user);
            },
            child: CardSpecialist(peer.name, ''),
          )
          : CardSpecialist(peer.name, '');
  }

  goToMap (BuildContext context, User peer, User user ) async{
    // await peer.updateMapMedic(peer.id);
    Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapPage(user, peer)));
  }
}
