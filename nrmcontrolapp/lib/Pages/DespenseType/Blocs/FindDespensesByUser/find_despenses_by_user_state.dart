import 'package:nrmcontrolapp/Models/DespenseType/despense_type.dart';

abstract class FindDespensesByUserState {}

class FindDespensesByUserSuccess implements FindDespensesByUserState {
  final List<DespenseType?>? data;

  const FindDespensesByUserSuccess(this.data);

  List<Object?> get props => [data];
}

class FindDespensesByUserLoading implements FindDespensesByUserState {
  const FindDespensesByUserLoading();
}

class FindDespensesByUserError implements FindDespensesByUserState {
  final String message;
  const FindDespensesByUserError(this.message);
}
