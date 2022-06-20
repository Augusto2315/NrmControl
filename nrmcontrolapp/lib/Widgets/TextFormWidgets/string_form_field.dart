import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Shared/Colors/icons_colors.dart';

import '../../Shared/Icons/flutter_icons.dart';

// ignore: must_be_immutable
class StringFormField extends StatefulWidget {
  StringFormField(
      {required this.labelText,
      required this.controller,
      this.isPassword = false,
      this.focusNode,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.sufixIcon,
      Key? key})
      : isOriginalPassword = isPassword,
        super(key: key);
  final TextEditingController controller;
  final String labelText;
  final FocusNode? focusNode;
  final Function(String str)? onFieldSubmitted;
  bool isPassword;
  final Icon? prefixIcon;
  final Icon? sufixIcon;
  final bool isOriginalPassword;
  @override
  State<StringFormField> createState() => _StringFormFieldState();
}

class _StringFormFieldState extends State<StringFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: widget.isOriginalPassword == true
            ? FlutterIcons.getLockerIcon()
            : widget.prefixIcon,
        suffixIcon: widget.isOriginalPassword
            ? IconButton(
                splashRadius: 25,
                color: IconsColors.stringTextFieldIconColor,
                onPressed: () => {
                  setState(
                    () => {widget.isPassword = !widget.isPassword},
                  )
                },
                icon: FlutterIcons.getPasswordIcon(widget.isPassword),
              )
            : widget.sufixIcon,
        labelText: widget.labelText,
      ),
    );
  }
}
