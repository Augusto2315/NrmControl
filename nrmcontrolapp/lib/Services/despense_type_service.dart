import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Repository/despense_type_repository.dart';

import '../Models/DespenseType/despense_type.dart';

class DespenseTypeService {
  Future<List<DespenseType>> getDespenseTypesByUser(
      String user, BuildContext context) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.getDespenseTypesByUser(user, context);
  }

  Future<DespenseType> createDespenseType(
      DespenseType despenseType, BuildContext context) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.createDespenseType(despenseType, context);
  }

  Future<DespenseType> updateDespenseType(
      DespenseType despenseType, BuildContext context) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.updateDespenseType(despenseType, context);
  }

  Future deleteDespenseType(DespenseType despenseType, BuildContext context) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.deleteDespenseType(despenseType, context);
  }
}
