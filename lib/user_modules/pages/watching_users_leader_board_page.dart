import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/components/dotted_border_component.dart';
import 'package:hourli/global_module/components/leader_board_card_component.dart';
import 'package:hourli/global_module/components/user_rank_card_component.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/global_module/utils/hl_fonts.dart';
import 'package:hourli/models/user_deatils_model.dart';
import 'package:hourli/user_modules/controllers/watching_users_leader_board_controller.dart';
import 'package:hourli/user_modules/pages/chat_page/chat_room.dart';
import 'package:hourli/user_modules/pages/chat_page/chat_v2/chat_v2_page.dart';
import 'package:hourli/user_modules/pages/search_user_page.dart';
import 'package:loading_indicator/loading_indicator.dart';

class WatchingUsersLeaderBoardPage extends StatefulWidget {
  @override
  _WatchingUsersLeaderBoardPageState createState() =>
      _WatchingUsersLeaderBoardPageState();
}

class _WatchingUsersLeaderBoardPageState
    extends State<WatchingUsersLeaderBoardPage> {
  // @override
  // bool get wantKeepAlive => true;

  WatchingUsersLeaderBoardController _watchingUsersLeaderBoardController;
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    _watchingUsersLeaderBoardController =
        Get.put<WatchingUsersLeaderBoardController>(
            WatchingUsersLeaderBoardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print("[Watings leaderboard page ] build called");
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 50.0,
              right: 15.0,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(LineAwesomeIcons.sms),
                      onPressed: () {
                        Get.to(ChatPage());
                      }),
                  IconButton(
                      icon: Icon(LineAwesomeIcons.search),
                      onPressed: () {
                        Get.to(SearchUserPage());
                      }),
                ],
              ),
            ),
            Positioned(
              top: 50.0,
              left: 15.0,
              child: Text(
                'Your Watchings',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            _buildPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    return Column(
      children: [
        SizedBox(height: 130.0),
        _buildMyStats(),
        DottedBorderComponent(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0)),
        _buildLeaderBoard(),
      ],
    );
  }

  Widget _buildMyStats() {
    return Obx(() => UserRankCardComponent(
              showContent: false,
              userDetailsModel: _userController.firestoreUserStream.value,
              rank: 0,
            )

        //  LeaderBoardCardComponent(
        //   userDetailsModel: _userController.firestoreUserStream.value,
        //   onTap: () {
        //     Get.toNamed('/hourlieUserDetailsPage',
        //         arguments: _userController.firestoreUserStream.value.uid);
        //   },
        // ),
        );
  }

  Widget _buildLeaderBoard() {
    return Expanded(
      child: StreamBuilder<List<String>>(
        stream: _watchingUsersLeaderBoardController.watchingUserIdsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                width: 30.0,
                height: 30.0,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotatePulse,
                  color: Colors.cyan,
                ),
              ),
            );
          } else {
            return _buildSortedUsers(watchingUserDocs: snapshot.data);
          }
        },
      ),
    );
  }

  Widget _buildSortedUsers({@required List<String> watchingUserDocs}) {
    if (watchingUserDocs.length == 0) {
      return Center(
        child: Text(
          "You are not watching any one.\n\nTap on search icon,\nFind your friend and watch him.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HLColors.secondaryColor,
            fontFamily: HLFonts.poppins,
            fontSize: 13.0,
          ),
        ),
      );
    }

    // build users
    return StreamBuilder<List<UserDetailsModel>>(
      stream: _watchingUsersLeaderBoardController.leaderBoardStream(
          watchingUserIds: watchingUserDocs),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              UserDetailsModel user = snapshot.data[index];
              return UserRankCardComponent(
                showContent: false,
                userDetailsModel: user,
                rank: index + 1,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error Loading cards'));
        } else {
          return Center(
            child: Container(
              width: 60.0,
              height: 60.0,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                color: Colors.cyan,
              ),
            ),
          );
        }
      },
    );
  }
}
