import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nrmcontrolapp/Repository/base_repository.dart';

import '../Models/CustomException/custom_exception.dart';
import '../Models/DespenseType/despense_type.dart';
import '../Services/http_service.dart';

class DespenseTypeRepository {
  static const String _route = "/despense-type";

  Future<List<DespenseType?>?> getDespenseTypesByUser(String userId) async {
    String methodRoute = '${BaseRepository().urlBase}$_route/$userId';
    final response = await HttpService().get(
      methodRoute,
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DespenseType?>? listaDespesas = body
          .map(
            (dynamic item) => DespenseType.fromJson(item),
          )
          .toList();

      return listaDespesas;
    }
    CustomException customException =
        CustomException.fromJson(jsonDecode(response.body));
    throw customException.detail;
  }
}
