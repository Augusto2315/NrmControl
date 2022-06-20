import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateFormField extends StatefulWidget {
  DateFormField(
      {required this.labelText,
      required this.controller,
      this.focusNode,
      this.onFieldSubmitted,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      Key? key})
      : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final FocusNode? focusNode;
  final Function(String str)? onFieldSubmitted;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  @override
  State<DateFormField> createState() => _DateFormFieldState();

  DateTime? selectedDate;
}

class _DateFormFieldState extends State<DateFormField> {
  DateTime? pickedDate;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.calendar_today),
        labelText: widget.labelText,
      ),
      readOnly: true,
      onTap: () async {
        pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime(2100),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);

          setState(() {
            widget.selectedDate = pickedDate;
            widget.controller.text = formattedDate;
          });
        }
      },
    );
  }
}
