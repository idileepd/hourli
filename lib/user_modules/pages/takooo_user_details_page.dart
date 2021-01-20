import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/global_module/components/customized/gradient_button_component.dart';
import 'package:hourli/global_module/components/heading_text_component.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/global_module/utils/hl_fonts.dart';
import 'package:hourli/models/user_deatils_model.dart';
import 'package:hourli/user_modules/controllers/hourli_user_details_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:hourli/user_modules/pages/user_timeline_component.dart';

class TakoooUserDetailsPage extends StatefulWidget {
  @override
  _TakoooUserDetailsPageState createState() => _TakoooUserDetailsPageState();
}

class _TakoooUserDetailsPageState extends State<TakoooUserDetailsPage> {
  final String thisPageUserUid = Get.arguments;
  HourliUserDetailsController _hourliUserDetailsController;
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    _hourliUserDetailsController =
        Get.put<HourliUserDetailsController>(HourliUserDetailsController());
    super.initState();
  }

  // ** use stream bind and use obx to rerender page. instead of stream builder.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          children: [
            HeadingTextComponent(title: 'User Details', showBack: true),
            _buildUserInfo(),
            if (_authController.firebaseUserStream.value.uid != thisPageUserUid)
              _buildWatchUnwatch(),
            UserTimelineComponent(uid: thisPageUserUid),
          ],
        ),
      ),
    );
  }

  StreamBuilder<UserDetailsModel> _buildUserInfo() {
    return StreamBuilder<UserDetailsModel>(
      stream:
          _hourliUserDetailsController.uesrDetailsStream(uid: thisPageUserUid),
      builder: (BuildContext context, snap) {
        if (snap.hasData) {
          return UserDetailsCardComponent(userDetailsModel: snap.data);
        } else if (snap.hasError) {
          return Text('Something went wrong !');
        } else {
          return Center(
            child: Container(
              width: 60.0,
              height: 60.0,
              child: LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
                color: HLColors.primaryColor,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildWatchUnwatch() {
    return StreamBuilder<DocumentSnapshot>(
      stream: _hourliUserDetailsController.authUserWatchingsUsersStream(
          uid: thisPageUserUid),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
        if (snap.hasData && snap.data != null) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: [
                Spacer(),
                _buildWatchUnwatchButton(docSnap: snap.data),
              ],
            ),
          );
        } else {
          return Center();
        }
      },
    );
  }

  Widget _buildWatchUnwatchButton({@required DocumentSnapshot docSnap}) {
    // If Auth user Watching this user !
    var data = docSnap.data();
    List<Color> colors = [];
    bool watching = false;
    String watchText = '';
    if (data != null && data['watching'] == true) {
      colors = HLColors.primaryColorsList;
      watching = true;
      watchText = 'Unwatch';
    } else {
      colors = HLColors.secondaryColorsList;
      watching = false;
      watchText = 'Watch';
    }
    return GradientButtonComponent(
      alignment: Alignment.topRight,
      width: 100,
      height: 50.0,
      gradientColors: colors,
      child: Text(watchText),
      onPressed: () {
        if (watching) {
          _hourliUserDetailsController.unwatchUser(
              unwatchingUserUid: thisPageUserUid);
        } else {
          _hourliUserDetailsController.watchUser(
              watchingUserUid: thisPageUserUid);
        }
      },
    );
  }
}

class UserDetailsCardComponent extends StatelessWidget {
  const UserDetailsCardComponent({
    Key key,
    @required this.userDetailsModel,
  }) : super(key: key);

  final UserDetailsModel userDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      // height: 200.0,
      // margin: const EdgeInsets.only(top: 50.0, left: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Column(
          children: [
            _buildUserPicName(),
            SizedBox(height: 20.0),
            _buildScoresWatchings(context),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Row _buildScoresWatchings(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Text(
                NumberFormat.compact().format(userDetailsModel.score),
                style: TextStyle(
                    fontSize: 3 * MediaQuery.of(context).size.height / 100,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Score",
                style: TextStyle(
                  fontSize: 1.9 * MediaQuery.of(context).size.height / 100,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Text(
                NumberFormat.compact().format(userDetailsModel.watchers),
                style: TextStyle(
                    fontSize: 3 * MediaQuery.of(context).size.height / 100,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Watchers",
                style: TextStyle(
                  fontSize: 1.9 * MediaQuery.of(context).size.height / 100,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Text(
                NumberFormat.compact().format(userDetailsModel.watchings),
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
        ),
      ],
    );
  }

  Row _buildUserPicName() {
    return Row(
      children: <Widget>[
        Container(
          width: 80.0,
          height: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(userDetailsModel.photoUrl),
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Flexible(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userDetailsModel.displayName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '@' + userDetailsModel.userName,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }
}
