import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Repository/despense_type_repository.dart';

import '../Models/DespenseType/despense_type.dart';

class DespenseTypeService {
  Future<List<DespenseType?>?> getDespenseTypesByUser(String user) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.getDespenseTypesByUser(user);
  }
}
