import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/Blocs/FindDespensesByUser/find_despenses_by_user_state.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Widgets/curved_navigation_bar.dart';

import '../../Models/DespenseType/despense_type.dart';
import 'Blocs/FindDespensesByUser/find_despenses_by_user_bloc.dart';
import 'DespenseTypeForm/despense_type_form_widget.dart';

class DespenseTypeWidget extends StatelessWidget {
  DespenseTypeWidget({Key? key}) : super(key: key);
  final FindDespenseByUserBloc findDespenseByUserBloc =
      FindDespenseByUserBloc();

  @override
  Widget build(BuildContext context) {
    findDespenseByUserBloc.add("NoremZ");
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<FindDespenseByUserBloc, FindDespensesByUserState>(
            bloc: findDespenseByUserBloc,
            builder: (context, state) {
              if (state is FindDespensesByUserError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is FindDespensesByUserLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              state = state as FindDespensesByUserSuccess;
              List<DespenseType?> listaDespesas = state.data!;
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => editDespenseType(listaDespesas[index]!),
                          child: Container(
                            height: 75,
                            color: Colors.white,
                            child: Center(
                                child: Text(listaDespesas[index]!.description)),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () => RouteService().editDespenseType(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void editDespenseType(DespenseType despenseType) {}
}
