import 'dart:convert';

import 'package:healing/HttpProtocol/HttpExecute.dart';
import 'package:healing/HttpProtocol/Status.dart';
import 'package:healing/Model/Count.dart';
import 'package:healing/Model/User.dart';
import 'package:http/http.dart';

class Validate {

  var data;

  Validate({this.data});

  checkKeyExists({String key = "", var initialize}) {
    return (data.containsKey(key) && data[key] != null)
            ? data[key]
            : initialize;
  }

  checkIsStatusOrResponse(VoidCallBackParam method) {
    return (data is Status)
            ? data
            : method(json.decode(data));
  }

  static bool isNotStatus(data) {
    return(data != null && data is !Status);
  }

  static bool isWrongEmailPassword(Response? response) {
    return response!.statusCode == 403;
  }

  static deleteUserAndCount(Count? count, User? user) async{
    if(count != null) {
      if(await count.delete(count.id) && user != null){
        if(await user.delete(user.id)) {
          count = null;
          user = null;
        }
      }
    }

    return (count == null && user == null);
  }

}