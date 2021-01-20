import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/components/customized/gradient_button_component.dart';
import 'package:hourli/global_module/components/customized/gradient_floating_action_btn.dart';
import 'package:hourli/global_module/controllers/local_notification_controller.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/user_modules/controllers/task_countdown_controller.dart';
import 'package:hourli/user_modules/pages/main_task_page/week_progress_bar_chart.dart';
import 'package:hourli/user_modules/pages/projects_page/projects_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hourli/user_modules/pages/user_recent_activity.dart';
import 'package:timer_builder/timer_builder.dart';

class MainTaskPage extends StatefulWidget {
  @override
  _MainTaskPageState createState() => _MainTaskPageState();
}

class _MainTaskPageState extends State<MainTaskPage> {
  final notificationController = Get.find<LocalNotificationController>();

  final _userController = Get.find<UserController>();
  TaskCountDownController _taskCountDownController;

  double widthOfWidget;
  double heightOfWidget;
  double heightOfWidget2;
  double buttonRadius;

  // DateTime endTime;
  @override
  void initState() {
    // endTime = DateTime.now().add(Duration(minutes: 2));
    _taskCountDownController = Get.put<TaskCountDownController>(
        TaskCountDownController(),
        permanent: true);
    Get.find<UserController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // For responsiveness
    // print("Height :: ${MediaQuery.of(context).size.height}");
    // print("40% Height :: ${MediaQucleanery.of(context).size.height * 0.4}");
    widthOfWidget = MediaQuery.of(context).size.width;
    heightOfWidget = (MediaQuery.of(context).size.height * 0.4) <= 300.0
        ? 300.0
        : MediaQuery.of(context).size.height * 0.4;

    heightOfWidget2 = (MediaQuery.of(context).size.height * 0.4) <= 300.0
        ? 300.0
        : MediaQuery.of(context).size.height * 0.5;
    buttonRadius = heightOfWidget - 100;

    // main page
    return SafeArea(
      top: false,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            _buildWeekProgress(),
            _buildTaskSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekProgress() {
    return Container(
      // color: Colors.red,
      height: heightOfWidget2,
      width: widthOfWidget,
      child: WeekProgressBarGraph(
        onTapLogs: () {
          Get.to(UserRecentActivity());
        },
      ),
    );
  }

  Widget _buildTaskSection() {
    return Container(
      width: widthOfWidget,
      height: heightOfWidget,
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: _buildTaskUpdates(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, right: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "TODAY | SCORE",
                        style: TextStyle(
                          // color: Colors.white70,
                          fontSize:
                              1.9 * MediaQuery.of(context).size.height / 100,
                          // fontFamily: 'poppins',
                        ),
                      ),
                      Obx(
                        () => Text(
                          NumberFormat.compact().format(_userController
                              .firestoreUserStream.value.today.todayScore),
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize:
                                  4 * MediaQuery.of(context).size.height / 100,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => _userController
                              .firestoreUserStream.value.currentTask.status ==
                          "STARTED"
                      ? Container(
                          width: 70.0,
                          height: 70.0,
                          child: GradientFloatingActionButtonComponent(
                            gradient: HLColors.secondaryGradient,
                            onTap: () {
                              Get.to(ProjectsPage());
                            },
                            icon: Icon(
                              LineAwesomeIcons.angle_double_right,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildTaskUpdates() {
    // DateTime startTime = DateTime.now();
    // DateTime endTime = (new DateTime.now())
    //     .add(new Duration(minutes: Duration.minutesPerHour));
    // print(startTime);
    // print(endTime);
    return SizedBox(
      width: buttonRadius,
      height: buttonRadius,
      child: Container(
        // color: Colors.red,
        child: Center(
          child: Obx(
            () =>
                _userController.firestoreUserStream.value.currentTask.status ==
                            null ||
                        _userController
                                .firestoreUserStream.value.currentTask.status ==
                            "COMPLETED" ||
                        _userController
                                .firestoreUserStream.value.currentTask.status ==
                            "FAILED" ||
                        _userController
                                .firestoreUserStream.value.currentTask.status ==
                            "DROPPED"
                    ? _buildPlayButton()
                    : _buildTimer(),
          ),
        ),
      ),
    );
  }

  TimerBuilder _buildTimer() {
    DateTime endTime =
        _userController.firestoreUserStream.value.currentTask.endsOn.toDate();
    return TimerBuilder.scheduled([endTime], builder: (context) {
      final now = Timestamp.now().toDate();
      // final started = now.compareTo(startTime) >= 0;
      // final ended = now.compareTo(endTime) >= 0;
      // return Text(started ? ended ? "Ended" : "Started" : "Not Started");
      if (now.isBefore(endTime)) {
        return _buildCurrentTaskTimer(endTime: endTime);
      } else {
        return _buildTaskEndedEventWidget();
      }
    });
  }

  Widget _buildPlayButton() {
    return SizedBox(
      width: buttonRadius,
      height: buttonRadius,
      child: GradientFloatingActionButtonComponent(
        gradient: HLColors.primaryGradient,
        onTap: () {
          Get.to(ProjectsPage());
        },
        icon: Icon(
          LineAwesomeIcons.play,
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }

  Widget _buildTaskEndedEventWidget() {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 60.0,
          // ),
          //
          Spacer(flex: 1),

          Expanded(
            flex: 5, // 60% of space => (6/(6 + 4))
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double width = constraints.maxWidth;
                  if (constraints.maxWidth < 200.0) {
                    width = constraints.maxWidth;
                  } else {
                    width = 200;
                  }
                  return GradientButtonComponent(
                    width: width,
                    height: 70,
                    alignment: Alignment.center,
                    gradientColors: HLColors.primaryGradient.colors,
                    child: Text('Completed Task'),
                    onPressed: () async {
                      try {
                        await _taskCountDownController.completedWork();
                        Get.snackbar('Success', "Progress saved successfully",
                            colorText: Colors.white);
                      } catch (e) {
                        Get.snackbar('Failed', e.toString(),
                            colorText: Colors.white);
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 5, // 60% of space => (6/(6 + 4))
            child: Container(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double width = constraints.maxWidth;
                  if (constraints.maxWidth < 200.0) {
                    width = constraints.maxWidth;
                  } else {
                    width = 200;
                  }
                  return GradientButtonComponent(
                    width: width,
                    height: 70,
                    alignment: Alignment.center,
                    gradientColors: HLColors.secondaryGradient.colors,
                    child: Text('Failed Task'),
                    onPressed: () async {
                      try {
                        await _taskCountDownController.failedWork();
                        Get.snackbar('Success', "Progress saved successfully",
                            colorText: Colors.white);
                      } catch (e) {
                        Get.snackbar('Failed', e.toString(),
                            colorText: Colors.white);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  TimerBuilder _buildCurrentTaskTimer({@required endTime}) {
    return TimerBuilder.periodic(Duration(seconds: 1), alignment: Duration.zero,
        builder: (context) {
      // This function will be called every second until the alert time
      var now = DateTime.now();
      // var remaining = startTime.difference(now);
      var remaining = endTime.difference(now);
      return _buildTimerComponent(remaining);
    });
  }

  Widget _buildTimerComponent(remaining) {
    return Column(
      children: [
        Spacer(flex: 1),
        Expanded(
          flex: 10, // 60% of space => (6/(6 + 4))
          child: Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double width = constraints.maxWidth;
                if (constraints.maxWidth < 200.0) {
                  width = constraints.maxWidth;
                } else {
                  width = 200;
                }
                return Text(
                  formatDuration(remaining),
                  style: TextStyle(fontSize: 60.0, letterSpacing: 6.0),
                );
              },
            ),
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 5, // 60% of space => (6/(6 + 4))
          child: Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double width = constraints.maxWidth;
                if (constraints.maxWidth < 200.0) {
                  width = constraints.maxWidth;
                } else {
                  width = 200;
                }
                return GradientButtonComponent(
                  width: width,
                  height: 50,
                  alignment: Alignment.center,
                  gradientColors: HLColors.primaryColorsList,
                  child: Text('Drop Task'),
                  onPressed: () async {
                    try {
                      await _taskCountDownController.dropTask();
                      Get.snackbar('Success', "Progress saved successfully",
                          colorText: Colors.white);
                    } catch (e) {
                      Get.snackbar('Failed', e.toString(),
                          colorText: Colors.white);
                    }
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
            flex: 2, // 60% of space => (6/(6 + 4))
            child: Text('Will add score upto this time')),
        Spacer(flex: 3),
        Expanded(
          flex: 5, // 60% of space => (6/(6 + 4))
          child: Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double width = constraints.maxWidth;
                if (constraints.maxWidth < 200.0) {
                  width = constraints.maxWidth;
                } else {
                  width = 200;
                }
                return GradientButtonComponent(
                  width: width,
                  height: 50,
                  alignment: Alignment.center,
                  gradientColors: HLColors.secondaryGradient.colors,
                  child: Text('Cancel Task'),
                  onPressed: () async {
                    try {
                      await _taskCountDownController.failedWork();
                      Get.snackbar('Success', "Progress saved successfully",
                          colorText: Colors.white);
                    } catch (e) {
                      Get.snackbar('Failed', e.toString(),
                          colorText: Colors.white);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
