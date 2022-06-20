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
}
