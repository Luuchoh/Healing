import 'package:healing/Common/Validate.dart';
import 'package:healing/DataBase/CRUD.dart';
import 'package:healing/DataBase/Tables.dart';
import 'package:healing/HttpProtocol/EndPoint.dart';

class Count extends CRUD{

  int id;
  String accessToken;
  String refreshToken;
  String createdAt;
  String expiresIn;
  String expiresTime;
  String tokenType;

  Count({
    this.id = 0,
    this.refreshToken = '',
    this.accessToken = '',
    this.createdAt = '',
    this.expiresIn = '',
    this.expiresTime = '',
    this.tokenType = '',
  }):super(Tables.COUNT);

  factory Count.toObject(Map<String, Object?> data) {
    Validate validate = Validate(data: data);
    return Count(
      id: validate.checkKeyExists(key: 'id', initialize: 0),
      accessToken: validate.checkKeyExists(key: 'access_token', initialize: ""),
      refreshToken: validate.checkKeyExists(key: 'refresh_token', initialize: ""),
      createdAt: validate.checkKeyExists(key: 'created_at', initialize: ""),
      expiresIn: validate.checkKeyExists(key: 'expires_in', initialize: "").toString(),
      expiresTime: validate.checkKeyExists(key: 'expires_time', initialize: ""),
      tokenType: validate.checkKeyExists(key: 'token_type', initialize: ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'created_at': createdAt,
    'expires_in': expiresIn,
    'expires_time': expiresTime,
    'token_type': tokenType,
    };
  }

  login(String email, String password) async{
    var data = await EndPoint.login(email, password);
    print("access $data");
    return Validate(data: data).checkIsStatusOrResponse(saveOrUpdate);
  }

  saveOrUpdate(data) async{
    Count count = addExpireTime(Count.toObject(data));
    count.id = (count.id > 0) ? await update(count.toMap()) : await insert(count.toMap());
    return count;
  }

  getCount() async{
    List<Map<String, Object?>> result = await query("SELECT * FROM ${Tables.COUNT}");
    return (result.isNotEmpty) ? Count.toObject(result[0]) : null;
  }

  addExpireTime(Count count) {
    var time = DateTime.now();
    count.expiresTime = time.add(Duration(seconds: int.parse(count.expiresIn))).toString();
    count.createdAt = time.toString();
    return count;
  }

  Future<Count> verifyToken() async{
    Count count = this;
    if(isInvalidAccessToken()){
      var refreshCount = await refreshAccessToken();
      if(Validate.isNotStatus(refreshCount)) {
        count = refreshCount;
      }
    }
    return count;
  }

  refreshAccessToken() async{
    var data = await EndPoint.refreshAccessToken(refreshToken);
    return Validate(data: data).checkIsStatusOrResponse(saveOrUpdate);
  }

  bool isInvalidAccessToken() {
    return DateTime.now().isAfter(DateTime.parse(expiresTime));
  }

}