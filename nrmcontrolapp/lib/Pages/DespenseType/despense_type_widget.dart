import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/Blocs/FindDespensesByUser/find_despenses_by_user_state.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Widgets/curved_navigation_bar.dart';

import '../../Models/DespenseType/despense_type.dart';
import 'Blocs/FindDespensesByUser/find_despenses_by_user_bloc.dart';

class DespenseTypeWidget extends StatelessWidget {
  DespenseTypeWidget({Key? key}) : super(key: key);
  final FindDespenseByUserBloc findDespenseByUserBloc =
      FindDespenseByUserBloc();

  @override
  Widget build(BuildContext context) {
    findDespenseByUserBloc.add("NoremZ");
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      bottomNavigationBar:
          CurvedNavgationBarWidget(PageIndexes.despenseTypePageIndex),
      body: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<FindDespenseByUserBloc, FindDespensesByUserState>(
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
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
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
                                editDespenseType(listaDespesas[index]!),
                            child: Container(
                              height: 50,
                              color: Colors.amber,
                              child: Center(
                                  child:
                                      Text(listaDespesas[index]!.description)),
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
                    backgroundColor: Colors.lightBlue,
                    child: const Icon(Icons.navigation),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void editDespenseType(DespenseType despenseType) {
    debugPrint(despenseType.toString());
  }
}
