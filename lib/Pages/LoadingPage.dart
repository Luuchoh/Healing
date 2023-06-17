import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healing/Values/ColorsApp.dart';
import 'package:healing/Widgets/SnackBarApp.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    permisions(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, primaryColor.withOpacity(0.48)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
              ),
              CircularProgressIndicator(color: primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  // verify location permission is activated
  permisions(BuildContext context) async{
    final status = await Permission.location.request();
    final gpsActive =  await Geolocator.isLocationServiceEnabled();
    switch ( status ) {
      case PermissionStatus.granted:
        if(!gpsActive) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBarApp(Text('Es necesario activar el GPS', style: TextStyle(color: Colors.white))));
          break;
        }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
