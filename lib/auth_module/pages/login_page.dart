import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/global_module/utils/hl_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginPage extends StatelessWidget {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildAppTitle(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                // _buildGoogleSignIn(),
                _buildLoading(),
                Spacer(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Obx(
      () => _authController.isLoging.value == true
          ? Container(
              width: 60.0,
              height: 60.0,
              child: LoadingIndicator(
                indicatorType: Indicator.ballScaleMultiple,
                color: Colors.cyan,
              ),
            )
          : GoogleSignInButton(
              onPressed: _authController.loginWithGoogle,
              textStyle: TextStyle(
                fontFamily: HLFonts.poppins,
              ),
              text: 'Continue With Google',
              darkMode: true,
            ),
    );
  }

  // GoogleSignInButton _buildGoogleSignIn() {
  //   return;
  // }

  Text _buildFooter() {
    return Text(
      'Created for lazy geeks',
      style: TextStyle(
        color: Colors.white,
        fontFamily: HLFonts.poppins,
        fontSize: 10.0,
      ),
    );
  }

  Widget _buildAppTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Text(
            'HOURLI',
            style: TextStyle(
              color: HLColors.primaryColor,
              fontSize: 80.0,
              fontWeight: FontWeight.w500,
              fontFamily: HLFonts.marqez,
              letterSpacing: 9.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'JUST FOCUS ON THIS HOUR',
            style: TextStyle(
              color: HLColors.secondaryColor,
              fontSize: 25.0,
              fontWeight: FontWeight.w400,
              fontFamily: HLFonts.marqez,
              letterSpacing: 5.0,
            ),
          ),
        ],
      ),
    );
  }
}
