import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Repository/user_repository.dart';

class UserService {
  Future<User> createUser(User user, BuildContext context) {
    UserRepository userRepository = UserRepository();
    return userRepository.createUser(user, context);
  }
}
