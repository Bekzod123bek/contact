import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showSnack(
    BuildContext context,
    String text, {
      bool success = true,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text.tr()),
      backgroundColor: success ? Colors.green : Colors.red,
    ),
  );
}
