import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nrmcontrolapp/Services/shared_preferences_utils.dart';

class JwtService {
  final String _key = 'jwtToken';
  Future<String?> getToken() async {
    return await SharedPreferencesUtils.getString(_key);
  }

  void setToken(String token) async {
    SharedPreferencesUtils.setString(_key, token);
  }

  void removeToken() async {
    SharedPreferencesUtils.removeString(_key);
  }

  static Future<bool> validateToken() async {
    JwtService jwtService = JwtService();
    String? jwtToken = await jwtService.getToken();

    if (jwtToken == null) {
      return false;
    } else if (!validateTokenExpiration(jwtToken)) {
      return false;
    }
    return true;
  }

  static bool validateTokenExpiration(String jwtToken) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
    int secondsSinceEpoch = decodedToken["exp"];
    debugPrint((DateTime.now().millisecondsSinceEpoch + 10000).toString());
    debugPrint((secondsSinceEpoch * 1000).toString());
    if (DateTime.now().millisecondsSinceEpoch + 10000 >
        secondsSinceEpoch * 1000) {
      return false;
    }
    return true;
  }
}
