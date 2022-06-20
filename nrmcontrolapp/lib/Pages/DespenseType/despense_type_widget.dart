import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/Blocs/FindDespensesByUser/find_despenses_by_user_state.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_state.dart';
import 'package:nrmcontrolapp/Services/despense_type_service.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/States/user_state.dart';
import 'package:provider/provider.dart';

import '../../Models/DespenseType/despense_type.dart';
import 'Blocs/FindDespensesByUser/find_despenses_by_user_bloc.dart';

class DespenseTypeWidget extends StatelessWidget {
  DespenseTypeWidget({Key? key}) : super(key: key);
  final FindDespenseByUserBloc findDespenseByUserBloc =
      FindDespenseByUserBloc();

  @override
  Widget build(BuildContext context) {
    findDespenseByUserBloc
        .add(Provider.of<UserState>(context).loggedUser.userId);
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
                          onTap: () =>
                              editDespenseType(listaDespesas[index]!, context),
                          child: Container(
                            height: 75,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Center(
                                  child: Text(
                                    listaDespesas[index]!.description,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () => deleteDespenseType(
                                    context,
                                    listaDespesas[index]!,
                                  ),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
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
                  onPressed: () => createDespenseType(context),
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

  void createDespenseType(BuildContext context) {
    Provider.of<DespenseTypeFormState>(context, listen: false).clearDespense();
    RouteService().editDespenseType();
  }

  void editDespenseType(DespenseType despenseType, BuildContext context) {
    Provider.of<DespenseTypeFormState>(context, listen: false)
        .alterDespense(despenseType);

    RouteService().editDespenseType();
  }

  void deleteDespenseType(BuildContext context, DespenseType despenseType) {
    DespenseTypeService().deleteDespenseType(despenseType).then((value) {
      findDespenseByUserBloc.add(
          Provider.of<UserState>(context, listen: false).loggedUser.userId);
    });
  }
}
