import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/components/account_page/menu_button_component.dart';
import 'package:hourli/global_module/controllers/theme_controller.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/user_modules/pages/account_page/account_instide_pages/about_us_page.dart';
import 'package:hourli/user_modules/pages/account_page/account_instide_pages/settings_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:hourli/user_modules/pages/user_recent_activity.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _userController = Get.find<UserController>();
  final _authController = Get.find<AuthController>();
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Obx(
            () => Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildThemeSwitch(),
                // Co(
                //   shrinkWrap: true,
                //   children: [
                _buildProfileImage(),
                _buildUserEmailUserName(),
                _buildUserInfo(),
                // ],
                // ),
                _buildMenuList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserEmailUserName() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 0.0),
      child: Column(
        children: [
          Text(
            _userController.firestoreUserStream.value.displayName,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 3.0),
          Text(
            '@' + _userController.firestoreUserStream.value.userName,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    Color color = _themeController.themeIndexRx.value == 1
        ? Theme.of(context).backgroundColor
        : HLColors.secondaryColor;
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          MenuButtonComponent(
            icon: LineAwesomeIcons.cog,
            text: 'My Activity',
            onTap: () {
              Get.to(UserRecentActivity());
            },
            color: color,
          ),
          // MenuButtonComponent(
          //   icon: LineAwesomeIcons.cog,
          //   text: 'Settings',
          //   onTap: () {
          //     Get.to(SettingPage());
          //   },
          //   color: color,
          // ),
          MenuButtonComponent(
            icon: LineAwesomeIcons.user_plus,
            text: 'Ask a Friend to Watch',
            onTap: () {
              Share.share(
                'check out this app just made for procrastinators \n\nhttps://hourli.web.app\nThis is my userName: ${_userController.firestoreUserStream.value.userName}',
                subject: 'Look what I got',
              );
            },
            color: color,
          ),
          MenuButtonComponent(
            icon: LineAwesomeIcons.user_plus,
            text: 'Invite a Friend',
            color: color,
            onTap: () {
              Share.share(
                'check out this app just made for procrastinators \n\nhttps://hourli.web.app',
                subject: 'Look what I got',
              );
            },
          ),
          MenuButtonComponent(
            icon: LineAwesomeIcons.question_circle,
            color: color,
            text: 'Help & About Us',
            onTap: () {
              Get.to(AboutUsPage());
            },
          ),

          MenuButtonComponent(
            icon: LineAwesomeIcons.alternate_sign_out,
            color: color,
            text: 'Logout',
            hasNavigation: false,
            onTap: () async {
              await _authController.logout();
            },
          ),
          SizedBox(height: 50.0)
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                NumberFormat.compact()
                    .format(_userController.firestoreUserStream.value.score),
                style: TextStyle(
                    fontSize: 3 * MediaQuery.of(context).size.height / 100,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Total Score",
                style: TextStyle(
                  fontSize: 1.9 * MediaQuery.of(context).size.height / 100,
                ),
              ),
            ],
          ),
          _getRowSpace(),
          Column(
            children: <Widget>[
              Text(
                NumberFormat.compact().format(
                    _userController.firestoreUserStream.value.watchings),
                style: TextStyle(
                    fontSize: 3 * MediaQuery.of(context).size.height / 100,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Watchings",
                style: TextStyle(
                  fontSize: 1.9 * MediaQuery.of(context).size.height / 100,
                ),
              ),
            ],
          ),
          _getRowSpace(),
          Column(
            children: <Widget>[
              Text(
                NumberFormat.compact()
                    .format(_userController.firestoreUserStream.value.watchers),
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 3 * MediaQuery.of(context).size.height / 100,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Watchers",
                style: TextStyle(
                  // color: Colors.white70,
                  fontSize: 1.9 * MediaQuery.of(context).size.height / 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _getRowSpace() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 10,
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.only(top: 3),
      child: CircleAvatar(
        radius: 200,
        backgroundImage:
            NetworkImage(_userController.firestoreUserStream.value.photoUrl),
      ),
    );
  }

  _buildThemeSwitch() {
    return Container(
      // color: Colors.yellow,
      margin: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 20.0),
            child: GestureDetector(
              onTap: _themeController.toggleTheme,
              child: Icon(
                _themeController.themeIndexRx.value == 1
                    ? LineAwesomeIcons.sun
                    : LineAwesomeIcons.moon,
                // LineAwesomeIcons.moon,
                size: 32.0,
                color: _themeController.themeIndexRx.value == 1
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
