import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/components/customized/gradient_button_component.dart';
import 'package:hourli/global_module/components/customized/gradient_floating_action_btn.dart';
import 'package:hourli/global_module/components/heading_text_component.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/models/user_deatils_model.dart';
import 'package:hourli/user_modules/controllers/task_countdown_controller.dart';

class TaskCountDownCreatePage extends StatefulWidget {
  final String taskId;
  final String projectId;
  final String projectName;
  final String taskName;
  final int taskType;

  const TaskCountDownCreatePage({
    Key key,
    @required this.taskId,
    @required this.projectId,
    @required this.projectName,
    @required this.taskName,
    @required this.taskType,
  }) : super(key: key);
  @override
  _TaskCountDownCreatePageState createState() =>
      _TaskCountDownCreatePageState();
}

class _TaskCountDownCreatePageState extends State<TaskCountDownCreatePage> {
  int minutes = 60;
  TaskCountDownController _taskCountDownController;
  UserController _userController;
  bool isPrivate = false;
  @override
  void initState() {
    _taskCountDownController = Get.find<TaskCountDownController>();
    _userController = Get.find<UserController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Start Work'),
        // ),
        floatingActionButton: Container(
          width: 70.0,
          height: 70.0,
          child: _buildStartFloatingBtn(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              // HeadingTextComponent(title: 'Start Work', showBack: true),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: Get.back,
                  ),
                  Text(
                    'Start work',
                    style: TextStyle(fontSize: 30.0),
                  )
                ],
              ),
              SizedBox(height: 5.0),

              Expanded(
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Text(
                      'What is your Target work time ?'.toUpperCase(),
                      style: TextStyle(fontSize: 30.0),
                    ),
                    SizedBox(height: 80.0),
                    Transform.scale(
                      scale: 2.0,
                      child: NumberPicker.integer(
                        initialValue: minutes,
                        minValue: 10,
                        maxValue: 180,
                        highlightSelectedValue: true,
                        onChanged: (v) {
                          // print(v);
                          setState(() {
                            minutes = v;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 200),
                    ListTile(
                      leading: Checkbox(
                          value: isPrivate,
                          onChanged: (val) {
                            setState(() {
                              isPrivate = val;
                            });
                          }),
                      subtitle: Text(
                          "Private task won't adds socre and won't notifiy others but, adds time spent "),
                      title: Text("Is private task ?"),
                    ),
                    SizedBox(height: 50),
                    if (widget.taskType == 0)
                      ListTile(
                        subtitle: Text(
                            "Will add score on complete and on partial drop and also notifies watchers"),
                        title: Text("This is Positive task"),
                      ),
                    if (widget.taskType == 1)
                      ListTile(
                        subtitle: Text(
                            "Don't add score but time spent will be counted and notifies watchers"),
                        title: Text("This is Negative task"),
                      ),
                    if (widget.taskType == 2)
                      ListTile(
                        subtitle: Text(
                            "Don't adds score timespent will be counted and notifies watchers"),
                        title: Text("This is Neutral task"),
                      ),
                    SizedBox(height: 60),
                    // _buildStartBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GradientFloatingActionButtonComponent _buildStartFloatingBtn() {
    return GradientFloatingActionButtonComponent(
      // alignment: Alignment.center,
      gradient: HLColors.primaryGradient,
      // child: Text('Start'),
      icon: Icon(LineAwesomeIcons.play),

      onTap: () async {
        if (_userController.firestoreUserStream.value.currentTask.status ==
            "STARTED") {
          Get.snackbar(
            "Failed",
            "You already started work!",
            colorText: Colors.white,
          );
          return;
        }
        Get.defaultDialog(
          content: CircularProgressIndicator(),
          barrierDismissible: false,
          title: "Please wait..",
        );
        CurrentTask currentTask = CurrentTask(
          projectId: widget.projectId,
          taskId: widget.taskId,
          taskName: widget.taskName,
          projectName: widget.projectName,
          targetMinutes: minutes,
          isPrivate: isPrivate,
          taskType: widget.taskType,
        );
        try {
          await _taskCountDownController.startWork(
            currentTask: currentTask,
          );
          Get.snackbar(
            "Success",
            "Work Started!",
            colorText: Colors.white,
          );
          if (widget.projectId != widget.taskId) {
            Get.back();
          }
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        } catch (e) {
          print(e);
          Get.snackbar(
            "Error",
            e.toString(),
            colorText: Colors.white,
          );
        } finally {}
      },
    );
  }

  GradientButtonComponent _buildStartBtn() {
    return GradientButtonComponent(
      width: 100.0,
      alignment: Alignment.center,
      gradientColors: HLColors.primaryGradient.colors,
      child: Text('Start'),
      onPressed: () async {
        if (_userController.firestoreUserStream.value.currentTask.status ==
            "STARTED") {
          Get.snackbar(
            "Failed",
            "You already started work!",
            colorText: Colors.white,
          );
          return;
        }
        Get.defaultDialog(
          content: CircularProgressIndicator(),
          barrierDismissible: false,
          title: "Please wait..",
        );
        CurrentTask currentTask = CurrentTask(
          projectId: widget.projectId,
          taskId: widget.taskId,
          taskName: widget.taskName,
          projectName: widget.projectName,
          targetMinutes: minutes,
          isPrivate: isPrivate,
        );
        try {
          await _taskCountDownController.startWork(
            currentTask: currentTask,
          );
          Get.snackbar(
            "Success",
            "Work Started!",
            colorText: Colors.white,
          );
          if (widget.projectId != widget.taskId) {
            Get.back();
          }
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        } catch (e) {
          print(e);
          Get.snackbar(
            "Error",
            e.toString(),
            colorText: Colors.white,
          );
        } finally {}
      },
    );
  }
}
