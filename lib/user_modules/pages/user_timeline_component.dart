import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline/flutter_timeline.dart';
import 'package:flutter_timeline/indicator_position.dart';
import 'package:flutter_timeline/timeline_theme.dart';
import 'package:flutter_timeline/timeline_theme_data.dart';
import 'package:get/get.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/models/activity_details_model.dart';
import 'package:hourli/user_modules/controllers/user_timeline_controller.dart';

class UserTimelineComponent extends StatefulWidget {
  final String uid;

  const UserTimelineComponent({Key key, @required this.uid}) : super(key: key);
  @override
  _UserTimelineComponentState createState() => _UserTimelineComponentState();
}

class _UserTimelineComponentState extends State<UserTimelineComponent> {
  UserTimeLineController _userTimeLineController;
  @override
  void initState() {
    _userTimeLineController =
        Get.put<UserTimeLineController>(UserTimeLineController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<TimelineEventDisplay>>(
        stream: _userTimeLineController.userActivityStream(uid: widget.uid),
        builder: (context, snap) {
          if (snap.hasData && snap.data != null) {
            if (snap.data.length == 0)
              return Column(
                children: [
                  SizedBox(height: 30.0),
                  Text('No activity made  to show'),
                ],
              );
            return _buildTimeline(events: snap.data);
          } else if (snap.hasError) {
            return Text('Error Loading timeline');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildTimeline({@required List<TimelineEventDisplay> events}) {
    return TimelineTheme(
      data: TimelineThemeData(
        lineColor: HLColors.primaryColorsList[1],
        itemGap: 100,
        lineGap: 0,
      ),
      child: Timeline(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        anchor: IndicatorPosition.top,
        indicatorSize: 56,
        altOffset: Offset(10, 40),
        events: events,
      ),
    );
  }
}
