import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableLabelWidget extends StatelessWidget {
  const ClickableLabelWidget(
      {required this.labelText, required this.onTap, Key? key})
      : super(key: key);
  final String labelText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: labelText,
        style: const TextStyle(
          color: Colors.black,
        ),
        recognizer: TapGestureRecognizer()..onTap = onTap,
      ),
    );
  }
}
