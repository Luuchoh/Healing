import 'package:healing/Common/Validate.dart';
import 'package:healing/DataBase/CRUD.dart';
import 'package:healing/DataBase/Tables.dart';
import 'package:healing/HttpProtocol/EndPoint.dart';

class User extends CRUD {
  int id;
  String userName;
  String name;
  String email;

  User({
    this.id = 0,
    this.userName = '',
    this.name = '',
    this.email = '',
  }):super(Tables.USER);

  factory User.toObject(Map<String, Object?> data) {
    Validate validate = Validate(data: data);
    return User(
      id: validate.checkKeyExists(key: 'id', initialize: 0),
      userName: validate.checkKeyExists(key: 'username', initialize: ""),
      name: validate.checkKeyExists(key: 'name', initialize: ""),
      email: validate.checkKeyExists(key: 'email', initialize: ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': userName,
      'name': name,
      'email': email,
    };
  }

  getUserServer() async{
    var data = await EndPoint.getUser();
    print("data user $data");
    return Validate(data: data).checkIsStatusOrResponse(saveOrUpdate);
  }

  saveOrUpdate(data) async{
    User user =  User.toObject(data);
    user.id = (user.id > 0) ? await update(user.toMap()) : await insert(user.toMap());
    return user;
  }

  Future<User?> getUserLocalDB() async{
    List<Map<String, Object?>> result = await query('SELECT * FROM ${Tables.USER}');
    return (result.isNotEmpty) ? User.toObject(result[0]): null;
  }
}