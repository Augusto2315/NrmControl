import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrmcontrolapp/Models/DespenseType/despense_type.dart';
import 'package:nrmcontrolapp/Services/despense_type_service.dart';

import 'find_despenses_by_user_state.dart';

class FindDespenseByUserBloc extends Bloc<String, FindDespensesByUserState> {
  FindDespenseByUserBloc(this._context)
      : super(
          const FindDespensesByUserSuccess([]),
        );

  final BuildContext _context;

  @override
  Stream<FindDespensesByUserState> mapEventToState(String event) async* {
    yield const FindDespensesByUserLoading();
    try {
      DespenseTypeService service = DespenseTypeService();
      List<DespenseType> listaDespesas =
          await service.getDespenseTypesByUser(event, _context);
      yield FindDespensesByUserSuccess(listaDespesas);
    } catch (e) {
      yield const FindDespensesByUserError("Deu ruim");
    }
  }
}
