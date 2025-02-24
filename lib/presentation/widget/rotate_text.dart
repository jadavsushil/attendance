import 'package:flutter/material.dart';

class RotatedText extends StatelessWidget {
  final String text;
  final int rotationQuarterTurns;
  final TextStyle? style;

  const RotatedText({
    Key? key,
    required this.text,
    required this.rotationQuarterTurns,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: rotationQuarterTurns == 1 ? 3 : 0,
      child: Text(
        text,
        maxLines: 2,
        style: style ?? const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}
