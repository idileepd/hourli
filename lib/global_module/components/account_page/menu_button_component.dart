import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MenuButtonComponent extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final void Function() onTap;
  final Color color;
  const MenuButtonComponent({
    Key key,
    @required this.icon,
    @required this.text,
    this.hasNavigation: true,
    @required this.color,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.0,
        margin: EdgeInsets.only(top: 15.0, left: 40.0, right: 40.0),
        padding: EdgeInsets.only(
          right: 15,
          left: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            Icon(
              icon,
              size: 20,
            ),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(
                  LineAwesomeIcons.angle_right,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
