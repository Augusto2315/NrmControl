import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
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
      validateExpiration(jwtToken, context);
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
      validateExpiration(jwtToken, context);
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
      validateExpiration(jwtToken, context);
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
      validateExpiration(jwtToken, context);
      cabecalhos.addAll({'Authorization': "Bearer $jwtToken"});
    }

    return http.delete(
      Uri.parse(url),
      headers: cabecalhos,
    );
  }

  void validateExpiration(String jwtToken, BuildContext context) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
    int secondsSinceEpoch = decodedToken["exp"];
    debugPrint((secondsSinceEpoch * 1000).toString());
    debugPrint(DateTime.now().millisecondsSinceEpoch.toString());
    if (DateTime.now().millisecondsSinceEpoch + 10000 >
        secondsSinceEpoch * 1000) {
      CustomToast.showWarning(
          "Sua sessão foi encerrada pois passou o limite de validação do token de acesso\nÉ necessário logar novamente!",
          context);
      RouteService().logout(context);
    }
  }
}
