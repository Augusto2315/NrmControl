import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_state.dart';
import 'package:nrmcontrolapp/Services/despense_type_service.dart';
import 'package:nrmcontrolapp/Widgets/Miscleaneous/custom_toast.dart';
import 'package:nrmcontrolapp/Widgets/TextFormWidgets/date_form_field.dart';
import 'package:nrmcontrolapp/Widgets/TextFormWidgets/string_form_field.dart';
import 'package:provider/provider.dart';

import '../../../Models/DespenseType/despense_type.dart';
import '../../../Models/User/user.dart';
import '../../../Services/route_service.dart';
import '../../../States/user_state.dart';
import '../../../Widgets/ButtonsWIdget/custom_button_widget.dart';

class DespenseTypeFormWidget extends StatefulWidget {
  const DespenseTypeFormWidget({Key? key}) : super(key: key);

  @override
  State<DespenseTypeFormWidget> createState() => _DespenseTypeFormWidgetState();
}

class _DespenseTypeFormWidgetState extends State<DespenseTypeFormWidget> {
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController startDateController = TextEditingController();
  late DespenseType despenseType;
  late DateFormField dateFormFieldWidget = DateFormField(
    controller: startDateController,
    labelText: 'Data Início',
  );

  @override
  void initState() {
    // final actValueController = TextEditingController(text: widget.Item.value);

    despenseType = Provider.of<DespenseTypeFormState>(context, listen: false)
        .getDespense();
    descriptionController.text = despenseType.description;
    startDateController.text = despenseType.startDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  onPressed: () => RouteService().despenseType(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: const Icon(Icons.keyboard_return),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StringFormField(
                  prefixIcon: const Icon(Icons.price_change),
                  labelText: "Descrição",
                  controller: descriptionController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Despesa Fixa"),
                    Switch(
                      value: Provider.of<DespenseTypeFormState>(context)
                          .getDespenseTypeMonthFixed(),
                      onChanged: (bool value) =>
                          alterMonthFixed(context, value),
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Visibility(
                  visible: Provider.of<DespenseTypeFormState>(context)
                      .getDespenseTypeMonthFixed(),
                  child: dateFormFieldWidget,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickIcon,
                      child: const Text('Open IconPicker'),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Provider.of<DespenseTypeFormState>(context)
                                  .getDespense()
                                  .iconData !=
                              null
                          ? Icon(IconData(
                              Provider.of<DespenseTypeFormState>(context)
                                  .getDespense()
                                  .iconData!))
                          : Container(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButtonWidget(
              onPressed: () => saveDespense(context),
              labelText: 'Salvar',
            ),
          ),
        ],
      ),
    );
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino, IconPack.material]);
    if (icon != null) {
      Provider.of<DespenseTypeFormState>(context, listen: false)
          .getDespense()
          .iconData = icon.codePoint;
      debugPrint('Picked Icon:  $icon');
    }
  }

  saveDespense(BuildContext context) {
    User user = Provider.of<UserState>(context, listen: false).loggedUser;
    DespenseType despenseType =
        Provider.of<DespenseTypeFormState>(context, listen: false)
            .getDespense();
    despenseType.userId = user.userId;
    despenseType.description = descriptionController.text;
    if (despenseType.monthFixed) {
      despenseType.startDate = dateFormFieldWidget.selectedDate;
    } else {
      despenseType.startDate = null;
    }
    if (!validateDespense(context, despenseType)) {
      return;
    }

    DespenseTypeService despenseTypeService = DespenseTypeService();
    despenseType.id > 0
        ? despenseTypeService
            .updateDespenseType(despenseType)
            .then((value) => goToDespenses(context))
        : despenseTypeService
            .createDespenseType(despenseType)
            .then((value) => goToDespenses(context));
  }

  void goToDespenses(BuildContext context) {
    Provider.of<DespenseTypeFormState>(context, listen: false).clearDespense();
    RouteService().despenseType();
  }

  bool validateDespense(BuildContext context, DespenseType despenseType) {
    bool valido = true;
    if (despenseType.description.isEmpty) {
      CustomToast.showError("Informe a descrição da despesa!", context);
      valido = false;
    } else if (despenseType.monthFixed && despenseType.startDate == null) {
      CustomToast.showError(
          "Informe a data de início da despesa se ela for fixada!", context);
      valido = false;
    }
    return valido;
  }

  alterMonthFixed(BuildContext context, bool monthFixed) {
    Provider.of<DespenseTypeFormState>(context, listen: false)
        .alterMonthFixed(monthFixed);
  }
}
