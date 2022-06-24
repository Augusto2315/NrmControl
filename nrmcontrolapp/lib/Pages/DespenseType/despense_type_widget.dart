import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/Blocs/FindDespensesByUser/find_despenses_by_user_state.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_state.dart';
import 'package:nrmcontrolapp/Services/despense_type_service.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';
import 'package:nrmcontrolapp/States/user_state.dart';
import 'package:provider/provider.dart';

import '../../Models/DespenseType/despense_type.dart';
import '../../Shared/Colors/icons_colors.dart';
import 'Blocs/FindDespensesByUser/find_despenses_by_user_bloc.dart';

class DespenseTypeWidget extends StatelessWidget {
  const DespenseTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final findDespenseByUserBloc = FindDespenseByUserBloc(context);

    void deleteDespenseType(BuildContext context, DespenseType despenseType) {
      DespenseTypeService()
          .deleteDespenseType(despenseType, context)
          .then((value) {
        findDespenseByUserBloc.add(
            Provider.of<UserState>(context, listen: false).loggedUser.userId);
      });
    }

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
              List<DespenseType> listaDespesas = state.data;
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () =>
                              editDespenseType(listaDespesas[index], context),
                          child: Container(
                            height: 75,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getIcon(listaDespesas[index]),
                                const Spacer(),
                                Center(
                                  child: Text(
                                    listaDespesas[index].description,
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    const Text("Despesa Fixa"),
                                    Switch(
                                      value: listaDespesas[index].monthFixed,
                                      onChanged: (bool value) => {},
                                      activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Colors.green,
                                      splashRadius: 0,
                                    ),
                                  ],
                                ),
                                IconButton(
                                  splashRadius: 40,
                                  splashColor: Colors.lightGreenAccent,
                                  onPressed: () => deleteDespenseType(
                                    context,
                                    listaDespesas[index],
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

  Widget getIcon(DespenseType despenseType) {
    if (despenseType.iconData != null) {
      return Icon(
        IconData(
          despenseType.iconData!,
          fontFamily: FlutterIcons.familyPackage,
        ),
        color: IconsColors.pickIconColor,
        size: 50,
      );
    }
    return Container(
      width: 50,
    );
  }
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
