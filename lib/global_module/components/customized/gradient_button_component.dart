import 'package:flutter/material.dart';

class GradientButtonComponent extends StatelessWidget {
  final double width;
  final double height;
  final List<Color> gradientColors;
  final Widget child;
  final void Function() onPressed;
  final double bottomBorderRadius;
  final double topBorderRadius;
  final EdgeInsets padding;
  final Alignment alignment;
  const GradientButtonComponent({
    Key key,
    this.width: 50.0,
    this.height: 50.0,
    this.topBorderRadius: 9.0,
    this.bottomBorderRadius: 9.0,
    @required this.gradientColors,
    @required this.child,
    @required this.onPressed,
    this.padding: const EdgeInsets.all(0.0),
    this.alignment: Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: alignment,
        child: Container(
          width: width,
          height: height,
          margin: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(topBorderRadius),
                bottom: Radius.circular(bottomBorderRadius)),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                offset: Offset(0, 3),
                color: gradientColors[0].withAlpha(16),
              )
            ],
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
