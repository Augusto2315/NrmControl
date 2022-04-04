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
import 'package:http/http.dart' as http;

class LoginRepository {
  static const String _route = "/login";

  Future<User?> login(User user) async {
    String methodRoute = '${BaseRepository().urlBase}$_route';
    final response = await http.post(
      Uri.parse(methodRoute),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      JwtService jwtService = JwtService();
      jwtService.removeToken();
      jwtService.setToken(jsonDecode(response.body));
      return user;
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.body));
    throw customException.detail;
  }
}
