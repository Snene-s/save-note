
import 'package:flutter/material.dart';
Future<void> scanModal(context,String code) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text('barcode'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text(code),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}