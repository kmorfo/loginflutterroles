import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {textColor = Colors.white, backgroundColor = Colors.red, icon = Icons.error}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const Icon(Icons.error)
      ],
    ),
    backgroundColor: Colors.red[500],
  ));
}
