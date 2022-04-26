import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Repository/base_repository.dart';
import 'package:nrmcontrolapp/Services/jwt_service.dart';

import '../Models/CustomException/custom_exception.dart';
import '../Services/http_service.dart';

class LoginRepository {
  static const String _route = "/login";

  Future<User?> login(User user) async {
    String methodRoute = '${BaseRepository().urlBase}$_route';
    final response = await HttpService().post(
      methodRoute,
      user,
    );
    if (response.statusCode == 200) {
      JwtService jwtService = JwtService();
      jwtService.removeToken();
      jwtService.setToken(response.body.toString());
      return user;
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.body));
    throw customException.detail;
  }
}
