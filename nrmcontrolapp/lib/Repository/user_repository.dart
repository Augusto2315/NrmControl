import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Repository/base_repository.dart';

import '../Models/CustomException/custom_exception.dart';
import '../Services/http_service.dart';

class UserRepository {
  static const String _route = "/user";

  Future<User> createUser(User user) async {
    String methodRoute = '${BaseRepository().urlBase}$_route';
    dynamic response = await HttpService().post(
      methodRoute,
      user,
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body.toString()));
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.data));
    throw customException.detail;
  }
}
