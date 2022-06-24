import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Shared/Functions/IconPicker/icon_picker_state.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/TextFormWidgets/string_form_field.dart';
import '../../Colors/icons_colors.dart';

class IconPicker {
  static Future<IconData?> showIconPicker(
      {required BuildContext context, IconData? defalutIcon}) async {
    IconData? selectedIcon = defalutIcon;
    TextEditingController controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha Um Ícone'),
        content: Container(
          width: 320,
          height: 400,
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: StringFormField(
                  controller: controller,
                  labelText: "Pesquisar",
                  prefixIcon: FlutterIcons.searchIcon,
                  onChanged: (String? str) => _onChanged(str, context),
                ),
              ),
              Expanded(
                flex: 6,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 60,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount:
                      Provider.of<IconPickerState>(context).getIcons.length,
                  itemBuilder: (_, index) => Container(
                    key: ValueKey(Provider.of<IconPickerState>(context)
                        .getIcons[index]
                        .iconData
                        .codePoint),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: IconButton(
                        color: IconsColors.pickIconColor,
                        splashRadius: 20,
                        icon: Icon(
                          Provider.of<IconPickerState>(context)
                              .getIcons[index]
                              .iconData,
                          size: 20,
                        ),
                        onPressed: () {
                          selectedIcon = Provider.of<IconPickerState>(context,
                                  listen: false)
                              .getIcons[index]
                              .iconData;
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          )
        ],
      ),
    );

    return selectedIcon;
  }

  static void _onChanged(String? filtro, BuildContext context) {
    Provider.of<IconPickerState>(context, listen: false)
        .getIconsByFilterLike(filtro);
  }
}
