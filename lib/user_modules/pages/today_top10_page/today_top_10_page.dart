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
import 'package:hourli/user_modules/controllers/all_user_leaderboard_controller.dart';
import 'package:hourli/user_modules/controllers/watching_users_leader_board_controller.dart';
import 'package:hourli/user_modules/pages/search_user_page.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AllUsersLeaderBoardPage extends StatefulWidget {
  @override
  _AllUsersLeaderBoardPageState createState() =>
      _AllUsersLeaderBoardPageState();
}

class _AllUsersLeaderBoardPageState extends State<AllUsersLeaderBoardPage> {
  // @override
  // bool get wantKeepAlive => true;

  AllUserLeaderBoardController _allUserLeaderBoardController;
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    _allUserLeaderBoardController =
        Get.put<AllUserLeaderBoardController>(AllUserLeaderBoardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print("[All leaderboard page ] build called");
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Top 10 Users',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    return _buildLeaderBoard();
  }

  Widget _buildLeaderBoard() {
    return Obx(
      () {
        List<UserDetailsModel> users =
            _allUserLeaderBoardController.todaytop10UsersModelsRx.value ?? null;
        if (users != null) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: users.length,
              itemBuilder: (context, index) {
                UserDetailsModel user = users[index];
                return UserRankCardComponent(
                  showContent: false,
                  userDetailsModel: user,
                  rank: index + 1,
                );
              },
            ),
          );
        } else {
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
        }
      },
    );
  }
}
