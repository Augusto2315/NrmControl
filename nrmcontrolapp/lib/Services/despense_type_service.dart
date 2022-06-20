import 'package:nrmcontrolapp/Repository/despense_type_repository.dart';

import '../Models/DespenseType/despense_type.dart';

class DespenseTypeService {
  Future<List<DespenseType?>?> getDespenseTypesByUser(String user) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.getDespenseTypesByUser(user);
  }

  Future<DespenseType> createDespenseType(DespenseType despenseType) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.createDespenseType(despenseType);
  }

  Future<DespenseType> updateDespenseType(DespenseType despenseType) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.updateDespenseType(despenseType);
  }

  Future deleteDespenseType(DespenseType despenseType) {
    DespenseTypeRepository despenseTypeRepository = DespenseTypeRepository();
    return despenseTypeRepository.deleteDespenseType(despenseType);
  }
}
