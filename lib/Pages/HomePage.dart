import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healing/DataBase/Firebase.dart';
import 'package:healing/Helpers/helpers.dart';
import 'package:healing/Pages/MapPage.dart';
import 'package:healing/Widgets/ActivateServices.dart';
import 'package:healing/Widgets/MoreInfo.dart';
import 'package:healing/Widgets/Specialists.dart';
import 'package:healing/Widgets/Specialties.dart';
import 'package:healing/Widgets/TextFormFieldBase.dart';
import 'package:geolocator/geolocator.dart';

import 'package:healing/Common/TransitionApp.dart';
import 'package:healing/Common/Validate.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';

import 'package:healing/Values/ColorsApp.dart';

class HomePage extends StatefulWidget {

  User user;
  Count count;

  HomePage(this.user, this.count);

  @override
  State createState() => HomePageState(user, count);

}
class HomePageState extends State<HomePage> with WidgetsBindingObserver {

  User user;
  Count count;

  HomePageState(this.user, this.count);

  List<User> users = [];
  StreamSubscription<DatabaseEvent>? onAddedSubs;
  StreamSubscription<DatabaseEvent>? onChangeSubs;

  @override
  void initState() {
    onAddedSubs = Firebase.tableUser.onChildAdded.listen(onEntryAdded);
    onChangeSubs = Firebase.tableUser.orderByChild('rol').equalTo('Médico').onChildChanged.listen(onEntryChanged);
    updateOnline(1);
    updateLocation();
    if(user.viewMap == 1) {
      goToMapMedic(user.userPatient);
    }
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  goToMapMedic(String id) async{
    User peer = await User().getUserFirebase(id);
    user.viewMap = 1;
    user.userPatient = id;
    if (peer.id != '0') {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapPage(user, peer, count)));
    }
  }

  onEntryAdded(DatabaseEvent event) async{
    User newUser = User.toUser(event.snapshot);
    if(mounted)
      setState(() {
        users.add(newUser);
      });
  }

  onEntryChanged(DatabaseEvent event) async{
    User oldEntry = users.singleWhere((entry) {
      return entry.id == event.snapshot.key;
    });
    User newUser = User.toUser(event.snapshot);
    if(mounted)
      setState(() {
        users[users.indexOf(oldEntry)] = newUser;
      });
    if(user.id == newUser.id && newUser.viewMap == 1){
      goToMapMedic(newUser.userPatient);
    }
  }

  void dispose() {
    onAddedSubs?.cancel();
    onChangeSubs?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Healing"),
        leading: Icon(
          Icons.menu
        ),
        actions: [
          IconButton(
            onPressed: () => closeSession(context),
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
          ),

        ],
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  MoreInfo(),
                  user.rol == 'Médico' ? ActivateServices(user) : SizedBox.shrink(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
                    child: TextFormFieldBase('Buscar...', Icons.search_outlined,),
                  ),
                  Specialties(),
                  Specialists(user, users, count),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state) {
      case AppLifecycleState.resumed:
        updateOnline(1);
        break;
      case AppLifecycleState.paused:
        updateOnline(0);
        break;
      default:
        break;
    }
  }
  updateLocation() async{
    Position position = await getLocation();
    user.latitude = position.latitude;
    user.longitude = position.longitude;
    user.updateLocation();
  }
  //Update isOnline user patient
  updateOnline(int isOnline, {bool session = false}) {
    if(user.rol == 'Paciente') {
      user.isOnline = isOnline;
      user.lastTime = DateTime.now().microsecondsSinceEpoch.toString();
    } else if(user.rol == 'Médico' && session) {
      user.isActive = isOnline;
      user.isOnline = isOnline;
      user.lastTime = DateTime.now().microsecondsSinceEpoch.toString();
    }
    user.updateIsActivate();
  }
  // Delete count and user for the State
  closeSession(BuildContext context) async{
    updateOnline(0, session: true);
    if(await Validate.deleteUserAndCount(count, user)) {
      TransitionApp.goMain(context);
    }
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // El servicio de ubicación está deshabilitado, muestra un mensaje o realiza una acción
      return Future.error('El servicio de ubicación está deshabilitado');
    }

    // Solicita permiso para acceder a la ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // El usuario ha negado permanentemente el permiso de ubicación, muestra un mensaje o realiza una acción
      return Future.error('El permiso de ubicación está denegado');
    }

    if (permission == LocationPermission.denied) {
      // El usuario ha negado el permiso de ubicación, solicita permiso
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // El usuario ha denegado el permiso de ubicación, muestra un mensaje o realiza una acción
        return Future.error('El permiso de ubicación está denegado');
      }
    }

    // Obtén la ubicación actual
    return await Geolocator.getCurrentPosition();
  }
}