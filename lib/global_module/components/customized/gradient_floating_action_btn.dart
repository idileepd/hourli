import 'package:flutter/material.dart';

class GradientFloatingActionButtonComponent extends StatelessWidget {
  final LinearGradient gradient;
  final void Function() onTap;
  final Icon icon;
  const GradientFloatingActionButtonComponent({
    Key key,
    @required this.gradient,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 60.0,
        // width: 60.0,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(10000.0),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0.0, .0), //(x,y)
          //     blurRadius: 2.0,
          //   ),
          // ],
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
