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

  User({
    this.id = '0',
    this.userName = '',
    this.name = '',
    this.email = '',
    this.isOnline = 0,
    this.isActive = 0,
    this.lastTime = '',
    this.rol = '',
  }):super(Tables.USER);

  factory User.toObjectFB(var snap) {
    return User(
      id: snap.key,
      userName: snap.value['userName'] == null ? '' : snap.value['userName'],
      name: snap.value['name'],
      email: snap.value['email'],
      isOnline: snap.value['isOnline'],
      isActive: snap.value['isActive'],
      lastTime: snap.value['lastTime'],
      rol: snap.value['rol']
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
      "rol": rol
    };
  }

  // firebase
  static getUserFirebase(String id) async {
    DatabaseEvent event = await Firebase.tableUser.child(id).once();
    return (event.snapshot.value != null) ? User.toObjectFB(event.snapshot): null;
  }

  save() {
    Firebase.tableUser.child(id).set(toMap());
  }
  updateIsActive() {
    Firebase.tableUser.child(id).update({"isActive": isActive});
  }

  updateIsOnline() {
    Firebase.tableUser.child(id).update({"isOnline": isOnline, "lastTime": lastTime});
  }

  //Auth0
  getUserServer() async{
    var data = await EndPoint.getUser();
    return Validate(data: data).checkIsStatusOrResponse(saveOrUpdate);
  }

  //Sqlite
  Future<User?> getUserLocalDB() async{
    List<Map<String, Object?>> result = await query('SELECT * FROM ${Tables.USER}');
    return (result.isNotEmpty) ? User.toObject(result[0]): null;
  }

  saveOrUpdate(data) async{
    var userLocalDB = [];
    User user = User.toObject(data);
    user.id = user.id.replaceFirst('auth0|', '');
    userLocalDB = await query('SELECT * FROM ${Tables.USER} WHERE id = ?', arguments: [user.id]);
    (userLocalDB.length > 0) ? await update(user.toMap()) : await insert(user.toMap());
    return user;
  }


}