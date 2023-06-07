// To parse this JSON data, do
//
//     final trafficResponse = trafficResponseFromJson(jsonString);

import 'dart:convert';

TrafficResponse trafficResponseFromJson(String str) => TrafficResponse.fromJson(json.decode(str));

String trafficResponseToJson(TrafficResponse data) => json.encode(data.toJson());

class TrafficResponse {
  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  TrafficResponse({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  factory TrafficResponse.fromJson(Map<String, dynamic> json) => TrafficResponse(
    routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromJson(x))),
    code: json["code"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
    "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
    "code": code,
    "uuid": uuid,
  };
}

class Route {
  String weightName;
  double weight;
  double duration;
  double distance;
  List<Leg> legs;
  String geometry;

  Route({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    weightName: json["weight_name"],
    weight: json["weight"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    distance: json["distance"]?.toDouble(),
    legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    geometry: json["geometry"],
  );

  Map<String, dynamic> toJson() => {
    "weight_name": weightName,
    "weight": weight,
    "duration": duration,
    "distance": distance,
    "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
    "geometry": geometry,
  };
}

class Leg {
  List<dynamic> viaWaypoints;
  List<Admin> admins;
  double weight;
  double duration;
  List<Step> steps;
  double distance;
  String summary;

  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
    admins: List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
    weight: json["weight"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    distance: json["distance"]?.toDouble(),
    summary: json["summary"],
  );

  Map<String, dynamic> toJson() => {
    "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
    "admins": List<dynamic>.from(admins.map((x) => x.toJson())),
    "weight": weight,
    "duration": duration,
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    "distance": distance,
    "summary": summary,
  };
}

class Admin {
  String iso31661Alpha3;
  String iso31661;

  Admin({
    required this.iso31661Alpha3,
    required this.iso31661,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    iso31661Alpha3: json["iso_3166_1_alpha3"],
    iso31661: json["iso_3166_1"],
  );

  Map<String, dynamic> toJson() => {
    "iso_3166_1_alpha3": iso31661Alpha3,
    "iso_3166_1": iso31661,
  };
}

class Step {
  List<Intersection> intersections;
  Maneuver maneuver;
  String name;
  double duration;
  double distance;
  DrivingSide drivingSide;
  double weight;
  Mode mode;
  String geometry;
  String? destinations;

  Step({
    required this.intersections,
    required this.maneuver,
    required this.name,
    required this.duration,
    required this.distance,
    required this.drivingSide,
    required this.weight,
    required this.mode,
    required this.geometry,
    this.destinations,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    intersections: List<Intersection>.from(json["intersections"].map((x) => Intersection.fromJson(x))),
    maneuver: Maneuver.fromJson(json["maneuver"]),
    name: json["name"],
    duration: json["duration"]?.toDouble(),
    distance: json["distance"]?.toDouble(),
    drivingSide: drivingSideValues.map[json["driving_side"]]!,
    weight: json["weight"]?.toDouble(),
    mode: modeValues.map[json["mode"]]!,
    geometry: json["geometry"],
    destinations: json["destinations"],
  );

  Map<String, dynamic> toJson() => {
    "intersections": List<dynamic>.from(intersections.map((x) => x.toJson())),
    "maneuver": maneuver.toJson(),
    "name": name,
    "duration": duration,
    "distance": distance,
    "driving_side": drivingSideValues.reverse[drivingSide],
    "weight": weight,
    "mode": modeValues.reverse[mode],
    "geometry": geometry,
    "destinations": destinations,
  };
}

enum DrivingSide { RIGHT, LEFT, SLIGHT_RIGHT, SLIGHT_LEFT }

final drivingSideValues = EnumValues({
  "left": DrivingSide.LEFT,
  "right": DrivingSide.RIGHT,
  "slight left": DrivingSide.SLIGHT_LEFT,
  "slight right": DrivingSide.SLIGHT_RIGHT
});

class Intersection {
  List<bool> entry;
  List<int> bearings;
  double? duration;
  MapboxStreetsV8? mapboxStreetsV8;
  bool? isUrban;
  int adminIndex;
  int? out;
  double? weight;
  int geometryIndex;
  List<double> location;
  int? intersectionIn;
  double? turnWeight;
  double? turnDuration;
  bool? trafficSignal;
  List<String>? classes;

  Intersection({
    required this.entry,
    required this.bearings,
    this.duration,
    this.mapboxStreetsV8,
    this.isUrban,
    required this.adminIndex,
    this.out,
    this.weight,
    required this.geometryIndex,
    required this.location,
    this.intersectionIn,
    this.turnWeight,
    this.turnDuration,
    this.trafficSignal,
    this.classes,
  });

  factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
    entry: List<bool>.from(json["entry"].map((x) => x)),
    bearings: List<int>.from(json["bearings"].map((x) => x)),
    duration: json["duration"]?.toDouble(),
    mapboxStreetsV8: json["mapbox_streets_v8"] == null ? null : MapboxStreetsV8.fromJson(json["mapbox_streets_v8"]),
    isUrban: json["is_urban"],
    adminIndex: json["admin_index"],
    out: json["out"],
    weight: json["weight"]?.toDouble(),
    geometryIndex: json["geometry_index"],
    location: List<double>.from(json["location"].map((x) => x?.toDouble())),
    intersectionIn: json["in"],
    turnWeight: json["turn_weight"]?.toDouble(),
    turnDuration: json["turn_duration"]?.toDouble(),
    trafficSignal: json["traffic_signal"],
    classes: json["classes"] == null ? [] : List<String>.from(json["classes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "entry": List<dynamic>.from(entry.map((x) => x)),
    "bearings": List<dynamic>.from(bearings.map((x) => x)),
    "duration": duration,
    "mapbox_streets_v8": mapboxStreetsV8?.toJson(),
    "is_urban": isUrban,
    "admin_index": adminIndex,
    "out": out,
    "weight": weight,
    "geometry_index": geometryIndex,
    "location": List<dynamic>.from(location.map((x) => x)),
    "in": intersectionIn,
    "turn_weight": turnWeight,
    "turn_duration": turnDuration,
    "traffic_signal": trafficSignal,
    "classes": classes == null ? [] : List<dynamic>.from(classes!.map((x) => x)),
  };
}

class MapboxStreetsV8 {
  Class? mapboxStreetsV8Class;

  MapboxStreetsV8({
    required this.mapboxStreetsV8Class,
  });

  factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) => MapboxStreetsV8(
    mapboxStreetsV8Class: classValues.map[json["class"]],
  );

  Map<String, dynamic> toJson() => {
    "class": classValues.reverse[mapboxStreetsV8Class],
  };
}

enum Class { SERVICE, TERTIARY, TRUNK, STREET, TRUNK_LINK, PRIMARY }

final classValues = EnumValues({
  "primary": Class.PRIMARY,
  "service": Class.SERVICE,
  "street": Class.STREET,
  "tertiary": Class.TERTIARY,
  "trunk": Class.TRUNK,
  "trunk_link": Class.TRUNK_LINK
});

class Maneuver {
  String type;
  String instruction;
  int bearingAfter;
  int bearingBefore;
  List<double> location;
  DrivingSide? modifier;

  Maneuver({
    required this.type,
    required this.instruction,
    required this.bearingAfter,
    required this.bearingBefore,
    required this.location,
    this.modifier,
  });

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
    type: json["type"],
    instruction: json["instruction"],
    bearingAfter: json["bearing_after"],
    bearingBefore: json["bearing_before"],
    location: List<double>.from(json["location"].map((x) => x?.toDouble())),
    modifier: drivingSideValues.map[json["modifier"]],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "instruction": instruction,
    "bearing_after": bearingAfter,
    "bearing_before": bearingBefore,
    "location": List<dynamic>.from(location.map((x) => x)),
    "modifier": drivingSideValues.reverse[modifier],
  };
}

enum Mode { DRIVING }

final modeValues = EnumValues({
  "driving": Mode.DRIVING
});

class Waypoint {
  double distance;
  String name;
  List<double> location;

  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
    distance: json["distance"]?.toDouble(),
    name: json["name"],
    location: List<double>.from(json["location"].map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "name": name,
    "location": List<dynamic>.from(location.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
