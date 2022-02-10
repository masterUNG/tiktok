import 'package:flutter/material.dart';
import 'package:tiktok/home.dart';

class ShowMenuPage extends StatelessWidget {
  const ShowMenuPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Page'),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          print('MenuPage Active');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false);
        },
      ),
    );
  }
}
