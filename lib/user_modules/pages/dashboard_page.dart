import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/user_modules/pages/account_page/account_page.dart';
import 'package:hourli/user_modules/pages/main_task_page/main_task_page.dart';
import 'package:hourli/user_modules/pages/today_top10_page/today_top_10_page.dart';
import 'package:hourli/user_modules/pages/watching_users_leader_board_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    // ALL INITS for
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('[Dashboard page] build');
    return SafeArea(
      top: false,
      child: Scaffold(
        body: IndexedStack(
          children: pages,
          index: _bottomNavIndex,
        ),
        bottomNavigationBar: _buildBottomNav2(),
      ),
    );
  }

  final iconList = <IconData>[
    Icons.done_outline,
    LineAwesomeIcons.user_friends,
    // LineAwesomeIcons.users,
    LineAwesomeIcons.user_cog,
  ];

  final List<Widget> pages = [
    MainTaskPage(),
    WatchingUsersLeaderBoardPage(),
    // AllUsersLeaderBoardPage(),
    AccountPage(),
  ];

  Widget _buildBottomNav2() {
    return AnimatedBottomNavigationBar(
      backgroundColor: Color(0xFF373A36),
      activeIndex: _bottomNavIndex,
      activeColor: HLColors.primaryColor,
      splashColor: HLColors.primaryColor,
      inactiveColor: Colors.white,
      splashSpeedInMilliseconds: 300,
      icons: iconList,
      iconSize: 25,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
    );
  }
}
