import 'package:firebase_database/firebase_database.dart';
import 'package:healing/Common/Validate.dart';
import 'package:healing/DataBase/CRUD.dart';
import 'package:healing/DataBase/Firebase.dart';
import 'package:healing/DataBase/Tables.dart';
import 'package:healing/HttpProtocol/EndPoint.dart';

class User extends CRUD {

  String id;
  String userName;
  String name;
  String email;

  int? isOnline;
  int? isActive;
  String? lastTime;
  String? rol;

  double latitude;
  double longitude;

  int viewMap;
  String userPatient;

  User({
    this.id = '0',
    this.userName = '',
    this.name = '',
    this.email = '',
    this.isOnline = 0,
    this.isActive = 0,
    this.lastTime = '',
    this.rol = '',
    this.latitude = 0.1,
    this.longitude = 0.1,
    this.viewMap= 0,
    this.userPatient = '',
  }):super(Tables.USER);

  static User toUser(var snap){
    return User(
      id: snap.key,
      userName: snap.value['username'] == null ? '' : snap.value['username'],
      name: snap.value['name'],
      email: snap.value['email'],
      isOnline: snap.value['isOnline'],
      isActive: snap.value['isActive'],
      lastTime: snap.value['lastTime'],
      rol: snap.value['rol'],
      latitude: snap.value['latitude'],
      longitude: snap.value['longitude'],
      viewMap: snap.value['viewMap'],
      userPatient: snap.value['userPatient'],
    );
  }

  // factory User.toObjectFB(var snap) {
  //   return User(
  //     id: snap.key,
  //     userName: snap.value['username'] == null ? '' : snap.value['username'],
  //     name: snap.value['name'],
  //     email: snap.value['email'],
  //     isOnline: snap.value['isOnline'],
  //     isActive: snap.value['isActive'],
  //     lastTime: snap.value['lastTime'],
  //     rol: snap.value['rol']
  //   );
  // }

  factory User.toObjectDBlocal(Map<String, Object?> data) {
    Validate validate = Validate(data: data);
    return User(
      id: validate.checkKeyExists(key: 'id', initialize: '0'),
      userName: validate.checkKeyExists(key: 'username', initialize: ""),
      name: validate.checkKeyExists(key: 'name', initialize: ""),
      email: validate.checkKeyExists(key: 'email', initialize: ""),
      rol: validate.checkKeyExists(key: 'rol', initialize: ""),
      isOnline: validate.checkKeyExists(key: 'isOnline', initialize: 0),
      isActive: validate.checkKeyExists(key: 'isActive', initialize: 0),
      lastTime: validate.checkKeyExists(key: 'lastTime', initialize: ""),
      latitude: validate.checkKeyExists(key: 'latitude', initialize: 0.1),
      longitude: validate.checkKeyExists(key: 'longitude', initialize: 0.1),
      viewMap: validate.checkKeyExists(key: 'viewMap', initialize: 0),
      userPatient: validate.checkKeyExists(key: 'userPatient', initialize: ""),
    );
  }

  factory User.toObject(Map<String, Object?> data) {
    Validate validate = Validate(data: data);
    return User(
      id: validate.checkKeyExists(key: 'sub', initialize: '0'),
      userName: validate.checkKeyExists(key: 'username', initialize: ""),
      name: validate.checkKeyExists(key: 'name', initialize: ""),
      email: validate.checkKeyExists(key: 'email', initialize: ""),
      rol: validate.checkKeyExists(key: 'rol', initialize: ""),
      isOnline: validate.checkKeyExists(key: 'isOnline', initialize: 0),
      isActive: validate.checkKeyExists(key: 'isActive', initialize: 0),
      lastTime: validate.checkKeyExists(key: 'lastTime', initialize: ""),
      latitude: validate.checkKeyExists(key: 'latitude', initialize: 0.1),
      longitude: validate.checkKeyExists(key: 'longitude', initialize: 0.1),
      viewMap: validate.checkKeyExists(key: 'viewMap', initialize: 0),
      userPatient: validate.checkKeyExists(key: 'userPatient', initialize: ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': userName,
      'name': name,
      'email': email,
      "isOnline": isOnline,
      "isActive": isActive,
      "lastTime": lastTime,
      "rol": rol,
      "latitude": latitude,
      "longitude": longitude,
      "viewMap": viewMap,
      "userPatient": userPatient,
    };
  }

  // firebase
  getUserFirebase(String id) async {
    DatabaseEvent event = await Firebase.tableUser.child(id).once();
    if (event.snapshot.value != null) {
      saveOrUpdate(event.snapshot);
      return User.toUser(event.snapshot);
    } else {
      return null;
    }
  }

  getUserPatientFirebase(String id) async {
    DatabaseEvent event = await Firebase.tableUser.child(id).once();
    if (event.snapshot.value != null) {
      return User.toUser(event.snapshot);
    } else {
      return null;
    }
  }

  save() {
    Firebase.tableUser.child(id).set(toMap());
  }

  updateIsActivate() {
    Firebase.tableUser.child(id).update({"isOnline": isOnline, "lastTime": lastTime, "isActive": isActive});
  }

  updateLocation() {
    print('entra');
    Firebase.tableUser.child(id).update({"latitude": latitude, "longitude": longitude});
  }

  updateMapMedic({required int stateMap, required String userPatient}) async{
    await Firebase.tableUser.child(id).update({"viewMap": stateMap, "userPatient": userPatient});
  }

  //Auth0
  getUserServer() async{
    var data = await EndPoint.getUser();
    return Validate(data: data).checkIsStatusOrResponse(saveOrUpdate);
  }

  //Sqlite
  Future<User?> getUserLocalDB() async{
    List<Map<String, Object?>> result = await query('SELECT * FROM ${Tables.USER}');
    return (result.isNotEmpty) ? User.toObjectDBlocal(result[0]): null;
  }

  saveOrUpdate(data) async{
    var userLocalDB = [];
    User user;
    if (data is DataSnapshot) {
      user = User.toUser(data);
    } else {
      user = User.toObject(data);
      user.id = user.id.replaceFirst('auth0|', '');
    }
    userLocalDB = await query('SELECT * FROM ${Tables.USER} WHERE id = ?', arguments: [user.id]);
    (userLocalDB.length > 0) ? await update(user.toMap()) : await insert(user.toMap());
    return user;
  }


}