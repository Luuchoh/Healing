import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healing/Common/Constant.dart';
import 'package:healing/HttpProtocol/HttpExecute.dart';

class Navigation {

  Navigation();

  static getRoute(LatLng initRoute, LatLng finalRoute) {
    final endpoint = '/mapbox/driving/${initRoute.longitude},${initRoute.latitude};${finalRoute.longitude},${finalRoute.latitude}';
    Map<String, dynamic> parameters = {
      "alternatives": "true",
      "geometries": "polyline",
      "language": "es",
      "overview": "simplified",
      "steps": "true",
      "access_token": MAPBOX_ACCESS_TOKEN,
    };

    return HttpExecute(URL_MAPBOX, endpoint: endpoint, queryparams: parameters).get();
  }
}