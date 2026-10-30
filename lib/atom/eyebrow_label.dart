import 'package:flutter/material.dart';

class EyebrowLabel extends StatelessWidget {
  const EyebrowLabel(this.text, {super.key, this.color, this.letterSpacing = 1.5});

  final String text;
  final Color? color;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) => Text(text.toUpperCase(), style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing,
        color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ));
}
