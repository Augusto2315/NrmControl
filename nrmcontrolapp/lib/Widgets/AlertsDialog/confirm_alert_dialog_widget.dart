import 'package:flutter/material.dart';

class DialogAlerts {
  static Future<bool> showConfirmAlertDialog({
    required BuildContext context,
    // required Function() onConfirm,
    // Function()? onCancel,
    required String title,
    required String text,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        Widget cancelButton = ElevatedButton(
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        );
        Widget continueButton = ElevatedButton(
          child: const Text("Confirmar"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        );
        AlertDialog alert = AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            text,
          ),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
        return alert;
      },
    );
  }
}
