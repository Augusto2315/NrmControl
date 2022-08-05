import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_state.dart';
import 'package:nrmcontrolapp/Services/despense_type_service.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';
import 'package:nrmcontrolapp/Widgets/Miscleaneous/custom_toast.dart';
import 'package:nrmcontrolapp/Widgets/TextFormWidgets/date_form_field.dart';
import 'package:nrmcontrolapp/Widgets/TextFormWidgets/string_form_field.dart';
import 'package:provider/provider.dart';

import '../../../Models/DespenseType/despense_type.dart';
import '../../../Models/User/user.dart';
import '../../../Services/route_service.dart';
import '../../../Shared/Functions/formats.dart';
import '../../../Shared/Functions/IconPicker/icon_picker.dart';
import '../../../States/user_state.dart';
import '../../../Widgets/ButtonsWIdget/custom_button_widget.dart';

class DespenseTypeFormWidget extends StatefulWidget {
  const DespenseTypeFormWidget({Key? key}) : super(key: key);

  @override
  State<DespenseTypeFormWidget> createState() => _DespenseTypeFormWidgetState();
}

class _DespenseTypeFormWidgetState extends State<DespenseTypeFormWidget> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  final TextEditingController startDateController = TextEditingController();
  late DespenseType despenseType;
  late DateFormField dateFormFieldWidget = DateFormField(
    controller: startDateController,
    initialDate: despenseType.startDate,
    labelText: 'Data Início',
  );

  @override
  void initState() {
    despenseType =
        Provider.of<DespenseTypeFormState>(context, listen: false).getDespense;
    descriptionController.text = despenseType.description;
    if (despenseType.monthFixed) {
      dateFormFieldWidget.selectedDate = despenseType.startDate;
      startDateController.text =
          Formats.getDateFormated(despenseType.startDate!);
      valueController.text = despenseType.value.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          Expanded(
            flex: 1,
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
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StringFormField(
                  prefixIcon: const Icon(Icons.price_change),
                  labelText: "Descrição",
                  controller: descriptionController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0, 0),
                  child: Visibility(
                    visible: Provider.of<DespenseTypeFormState>(context)
                        .getDespenseTypeMonthFixed(),
                    child: StringFormField(
                      prefixIcon: const Icon(Icons.money),
                      textInputType: TextInputType.number,
                      labelText: "Valor",
                      controller: valueController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0, 0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickIcon,
                        child: const Text('Escolher Ícone'),
                      ),
                      SizedBox(
                        child: IconButton(
                          iconSize: 50,
                          icon: Provider.of<DespenseTypeFormState>(
                            context,
                            listen: false,
                          ).getIcon(),
                          splashRadius: 20,
                          onPressed: () => _pickIcon(),
                        ),
                      ),
                    ],
                  ),
                ),
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
    int? codePointIcon =
        Provider.of<DespenseTypeFormState>(context, listen: false)
            .getDespense
            .iconData;

    IconData? icon = await IconPicker.showIconPicker(
      context: context,
      defalutIcon: codePointIcon != null
          ? IconData(
              codePointIcon,
              fontFamily: FlutterIcons.familyPackage,
            )
          : null,
    );
    if (icon != null) {
      Provider.of<DespenseTypeFormState>(context, listen: false)
          .setIconCodePoint(icon.codePoint);
    }
  }

  saveDespense(BuildContext context) {
    final User user = Provider.of<UserState>(context, listen: false).loggedUser;
    DespenseType despenseType =
        Provider.of<DespenseTypeFormState>(context, listen: false).getDespense;
    despenseType.userId = user.userId;
    despenseType.description = descriptionController.text;
    if (despenseType.monthFixed) {
      despenseType.startDate = dateFormFieldWidget.selectedDate;
      despenseType.value = double.tryParse(valueController.text);
    } else {
      despenseType.startDate = null;
    }
    if (!validateDespense(context, despenseType)) {
      return;
    }

    DespenseTypeService despenseTypeService = DespenseTypeService();
    despenseType.id > 0
        ? despenseTypeService
            .updateDespenseType(
              despenseType,
              context,
            )
            .then(
              (value) => goToDespenses(context),
            )
        : despenseTypeService
            .createDespenseType(
              despenseType,
              context,
            )
            .then(
              (value) => goToDespenses(context),
            );
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
    } else if (despenseType.monthFixed) {
      if (despenseType.startDate == null) {
        CustomToast.showError(
          "Informe a data de início da despesa se ela for fixada!",
          context,
        );
        valido = false;
      } else if (despenseType.value == null) {
        CustomToast.showError(
          "Informe o valor da despesa fixa!",
          context,
        );
        valido = false;
      }
    }
    return valido;
  }

  alterMonthFixed(BuildContext context, bool monthFixed) {
    Provider.of<DespenseTypeFormState>(context, listen: false)
        .alterMonthFixed(monthFixed);
  }
}
