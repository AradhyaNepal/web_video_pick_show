import 'package:flutter/material.dart';

void showErrorToast(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    errorSnackBar(title),
  );
}

SnackBar errorSnackBar(String title) {
  return SnackBar(
    content: Text(
      title,
    ),
  );
}
