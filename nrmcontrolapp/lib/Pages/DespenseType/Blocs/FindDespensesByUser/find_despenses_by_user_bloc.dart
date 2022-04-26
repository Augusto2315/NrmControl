import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrmcontrolapp/Services/despense_type_service.dart';

import 'find_despenses_by_user_state.dart';

class FindDespenseByUserBloc extends Bloc<String, FindDespensesByUserState> {
  FindDespenseByUserBloc() : super(const FindDespensesByUserSuccess([]));

  @override
  Stream<FindDespensesByUserState> mapEventToState(String user) async* {
    yield const FindDespensesByUserLoading();
    try {
      DespenseTypeService service = DespenseTypeService();
      yield FindDespensesByUserSuccess(
          await service.getDespenseTypesByUser(user));
    } catch (e) {
      yield const FindDespensesByUserError("Deu ruim");
    }
  }
}
