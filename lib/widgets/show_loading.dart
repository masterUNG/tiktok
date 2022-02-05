import 'package:flutter/material.dart';
import 'package:tiktok/variables.dart';
import 'package:tiktok/widgets/show_progress.dart';

class ShowLoading extends StatelessWidget {
  const ShowLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Uploading......", style: mystyle(25)),
        const SizedBox(height: 20),
        const ShowProgress(),
      ],
    );
  }
}
