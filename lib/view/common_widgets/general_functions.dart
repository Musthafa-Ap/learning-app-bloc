import 'package:flutter/material.dart';

showSnackBarMessage({required BuildContext context, required String msg}) {
  SnackBar snackBar = SnackBar(
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
