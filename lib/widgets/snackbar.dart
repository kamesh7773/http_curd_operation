import 'package:flutter/material.dart';

void showSnackBar(String data, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(data),
    ),
  );
}
