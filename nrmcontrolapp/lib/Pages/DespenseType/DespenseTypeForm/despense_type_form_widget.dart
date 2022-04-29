import 'package:flutter/material.dart';

import '../../../Models/DespenseType/despense_type.dart';
import '../../../Widgets/curved_navigation_bar.dart';

class DespenseTypeFormWidget extends StatefulWidget {
  const DespenseTypeFormWidget({
    Key? key,
    this.despenseType,
  }) : super(key: key);

  final DespenseType? despenseType;

  @override
  State<DespenseTypeFormWidget> createState() => _DespenseTypeFormWidgetState();
}

class _DespenseTypeFormWidgetState extends State<DespenseTypeFormWidget> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  late DespenseType despenseType;

  @override
  void initState() {
    despenseType = widget.despenseType == null
        ? DespenseType(0, "", "NoremZ", false, null)
        : widget.despenseType!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Descrição',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Switch(
              value: despenseType.monthFixed,
              onChanged: (bool value) => despenseType.monthFixed = value,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          Visibility(
            visible: despenseType.monthFixed == true,
            child: TextFormField(
              controller: startDateController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Data Início',
              ),
            ),
          )
        ],
      ),
    );
  }
}
