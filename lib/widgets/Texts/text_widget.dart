import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String txt;
  const TextWidget({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}
