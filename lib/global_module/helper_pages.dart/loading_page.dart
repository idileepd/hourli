import 'package:flutter/material.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/global_module/utils/hl_fonts.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              color: HLColors.secondaryColor,
              fontSize: 30.0,
              fontFamily: HLFonts.marqez,
              letterSpacing: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
