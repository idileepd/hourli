import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadingTextComponent extends StatelessWidget {
  final String title;
  final bool showBack;
  const HeadingTextComponent({
    Key key,
    @required this.title,
    @required this.showBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 50.0, bottom: 10.0),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: Get.back,
            ),
          if (showBack) SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
