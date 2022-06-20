import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Shared/Styles/custom_button_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {required this.onPressed, required this.labelText, Key? key})
      : super(key: key);
  final Function() onPressed;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: CustomButtonStyles.style,
      onPressed: onPressed,
      child: Text(labelText),
    );
  }
}
