

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(40),
    ),
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
    onPressed: onClicked,
  );
}