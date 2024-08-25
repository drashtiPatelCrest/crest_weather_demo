import 'dart:ui';

import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  String text;
  TextAlign textAlign;

  MediumText({super.key, required this.text, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textAlign: textAlign,
    );
  }
}
