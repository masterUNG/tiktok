// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    @required this.context,
  });

  Future<void> normalDialog(String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const Icon(Icons.alarm_rounded, size: 48,),
          title: Text(title),
          subtitle: Text(message),
        ),actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }
}
