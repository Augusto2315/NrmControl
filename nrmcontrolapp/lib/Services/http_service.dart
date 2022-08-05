import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nrmcontrolapp/Services/jwt_service.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Widgets/Miscleaneous/custom_toast.dart';

class HttpService {
  Future<dynamic> post(String url, dynamic object, BuildContext context) async {
    Map<String, String> cabecalhos = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    JwtService jwtService = JwtService();
    String? jwtToken = await jwtService.getToken();
    if (jwtToken != null && jwtToken.isNotEmpty) {
      logoutIfInvalid(JwtService.validateTokenExpiration(jwtToken), context);
      cabecalhos.addAll({'Authorization': "Bearer $jwtToken"});
    }

    return http.post(
      Uri.parse(url),
      headers: cabecalhos,
      body: jsonEncode(object.toJson()),
    );
  }

  Future<dynamic> put(String url, dynamic object, BuildContext context) async {
    Map<String, String> cabecalhos = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    JwtService jwtService = JwtService();
    String? jwtToken = await jwtService.getToken();
    if (jwtToken != null && jwtToken.isNotEmpty) {
      logoutIfInvalid(JwtService.validateTokenExpiration(jwtToken), context);
      cabecalhos.addAll({'Authorization': "Bearer $jwtToken"});
    }

    return http.put(
      Uri.parse(url),
      headers: cabecalhos,
      body: jsonEncode(object.toJson()),
    );
  }

  Future<dynamic> get(String url, BuildContext context) async {
    Map<String, String> cabecalhos = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    JwtService jwtService = JwtService();
    String? jwtToken = await jwtService.getToken();
    if (jwtToken != null && jwtToken.isNotEmpty) {
      logoutIfInvalid(JwtService.validateTokenExpiration(jwtToken), context);
      cabecalhos.addAll({'Authorization': "Bearer $jwtToken"});
    }

    return http.get(
      Uri.parse(url),
      headers: cabecalhos,
    );
  }

  Future<dynamic> delete(String url, BuildContext context) async {
    Map<String, String> cabecalhos = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    JwtService jwtService = JwtService();
    String? jwtToken = await jwtService.getToken();
    if (jwtToken != null && jwtToken.isNotEmpty) {
      logoutIfInvalid(JwtService.validateTokenExpiration(jwtToken), context);
      cabecalhos.addAll({'Authorization': "Bearer $jwtToken"});
    }

    return http.delete(
      Uri.parse(url),
      headers: cabecalhos,
    );
  }

  void logoutIfInvalid(bool invalid, BuildContext context) {
    if (invalid) {
      CustomToast.showWarning(
          "Sua sessão foi encerrada pois passou o limite de validação do token de acesso\nÉ necessário logar novamente!",
          context);
      RouteService().logout(context);
    }
  }
}
