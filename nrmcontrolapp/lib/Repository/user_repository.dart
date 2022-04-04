import 'dart:convert';

import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Repository/base_repository.dart';

import '../Models/CustomException/custom_exception.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  static const String _route = "/user";

  Future<User> createUser(User user) async {
    String methodRoute = '${BaseRepository().urlBase}$_route';
    final response = await http.post(
      Uri.parse(methodRoute),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.toString()));
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.body));
    throw customException.detail;
  }
}
