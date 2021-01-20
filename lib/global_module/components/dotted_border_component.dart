import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedBorderComponent extends StatelessWidget {
  final color;
  final EdgeInsets padding;
  const DottedBorderComponent(
      {Key key,
      this.color: const Color(0xFFE1E1E1),
      this.padding: const EdgeInsets.all(0.0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DottedBorder(
        color: color,
        dashPattern: [7, 7],
        customPath: (size) {
          return Path()
            ..moveTo(0, 10)
            ..lineTo(size.width, 10);
        },
        child: Container(),
      ),
    );
  }
}
