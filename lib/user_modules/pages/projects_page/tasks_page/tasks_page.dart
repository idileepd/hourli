import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hourli/global_module/components/customized/gradient_floating_action_btn.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/models/project_details_model.dart';
import 'package:hourli/models/task_details_model.dart';
import 'package:hourli/user_modules/controllers/project_controller.dart';
import 'package:hourli/user_modules/controllers/task_controller.dart';
import 'package:hourli/user_modules/pages/projects_page/update_projet.dart';
import 'package:hourli/user_modules/pages/task_coundown_create_page.dart';

class TasksPage extends StatefulWidget {
  final ProjectDetailsModel projectDetailsModel;

  const TasksPage({Key key, @required this.projectDetailsModel})
      : super(key: key);
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TaskController _taskController;
  ProjectController _projectController;

  String taskName = '';
  @override
  void initState() {
    _taskController = Get.put<TaskController>(
        TaskController(projectDetailsModel: widget.projectDetailsModel));
    _projectController = Get.find<ProjectController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        floatingActionButton: Container(
          width: 70.0,
          height: 70.0,
          child: GradientFloatingActionButtonComponent(
            gradient: HLColors.primaryGradient,
            onTap: _addTask,
            icon: Icon(
              LineAwesomeIcons.plus,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            // SizedBox(height: 30.0),
            // _buildHeader(),
            // HeadingTextComponent(title: 'Tasks', showBack: true),
            _buildHeadBar(),
            _buildProjectInformation(),
            SizedBox(height: 30.0),
            _buildTasks()
            // TextField()
            // _(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 50.0, bottom: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: Get.back,
          ),
          Text(
            'Tasks',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
          Spacer(),
          IconButton(
            icon: Icon(LineAwesomeIcons.vertical_ellipsis),
            onPressed: () {
              Get.defaultDialog(
                  title: "Project Options",
                  content: Column(
                    children: [
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.to(
                            UpdateProjectPage(
                              projectName:
                                  widget.projectDetailsModel.projectName,
                              projectId: widget.projectDetailsModel.projectId,
                              projectColor: Color(
                                int.parse(
                                  '0xFF${widget.projectDetailsModel.colorHex}',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text('Edit Project'),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          await _projectController.deleteProject(
                              projectId: widget.projectDetailsModel.projectId);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('Delete Project'),
                      ),
                    ],
                  ));
            },
            iconSize: 27.0,
          ),
        ],
      ),
    );
  }

  Widget _buildTasks() {
    return Obx(() {
      List<TaskDetailsModel> inCompletedTasks =
          _taskController.inCompleteTasksRx.value;
      List<TaskDetailsModel> completedTasks =
          _taskController.completeTasksRx.value;
      if (inCompletedTasks == null || completedTasks == null) {
        return CircularProgressIndicator();
      }

      List<TaskDetailsModel> total = [...inCompletedTasks, ...completedTasks];
      if (total.length == 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.0),
            Text(
              "No tasks added\nTap '+' button to create task",
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: total.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: "Project Options",
                  content: Column(
                    children: [
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Edit Task'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _taskController.deleteTask(
                              projectId: widget.projectDetailsModel.projectId,
                              taskId: total[index].taskId);
                          Navigator.of(context).pop();
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('Delete Task'),
                      ),
                    ],
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Checkbox(
                    value: total[index].isCompleted,
                    onChanged: (val) {
                      // print(val);
                      _taskController.updateTaskStatus(
                        projectId: widget.projectDetailsModel.projectId,
                        taskStatus: val,
                        taskId: total[index].taskId,
                      );
                    },
                  ),
                  title: Text(
                    total[index].taskName,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  // subtitle: Text(),
                  subtitle: Text(
                    NumberFormat.compact().format(total[index].minutesSpent) +
                        " Min Spent",
                  ),
                  trailing: total[index].isCompleted == true
                      ? null
                      : IconButton(
                          onPressed: () {
                            Get.to(
                              TaskCountDownCreatePage(
                                taskId: total[index].taskId,
                                projectId: widget.projectDetailsModel.projectId,
                                projectName:
                                    widget.projectDetailsModel.projectName,
                                taskName: total[index].taskName,
                                taskType:
                                    widget.projectDetailsModel.projectType,
                              ),
                            );
                          },
                          icon: Icon(
                            LineAwesomeIcons.stopwatch,
                            size: 30.0,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildProjectInformation() {
    return Obx(() {
      ProjectDetailsModel projectDetailsModel =
          _taskController.projectDetailsRx?.value ?? null;
      if (projectDetailsModel == null) return CircularProgressIndicator();
      return GestureDetector(
        onTap: () {
          Get.to(
            UpdateProjectPage(
              projectName: projectDetailsModel.projectName,
              projectId: projectDetailsModel.projectId,
              projectColor: Color(
                int.parse('0xFF${projectDetailsModel.colorHex}'),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  projectDetailsModel.projectName,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: Get.back,
              iconSize: 25.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Tasks',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
        IconButton(
          icon: Icon(LineAwesomeIcons.vertical_ellipsis),
          onPressed: () {
            Get.defaultDialog(
                title: "Project Options",
                content: Column(
                  children: [
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.to(
                          UpdateProjectPage(
                            projectName: widget.projectDetailsModel.projectName,
                            projectId: widget.projectDetailsModel.projectId,
                            projectColor: Color(
                              int.parse(
                                '0xFF${widget.projectDetailsModel.colorHex}',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text('Edit Project'),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        await _projectController.deleteProject(
                            projectId: widget.projectDetailsModel.projectId);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Delete Project'),
                    ),
                  ],
                ));
          },
          iconSize: 27.0,
        ),
      ],
    );
  }

  _addTask() {
    taskName = '';
    Get.defaultDialog(
      barrierDismissible: false,
      onConfirm: () async {
        try {
          if (taskName.length > 0) {
            Get.defaultDialog(
              content: CircularProgressIndicator(),
              title: 'Please wait...',
              barrierDismissible: false,
            );
            await _taskController.createTask(
              projectId: widget.projectDetailsModel.projectId,
              taskName: taskName,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          }
        } catch (e) {
          Get.defaultDialog(
            // content: CircularProgressIndicator(),
            title: 'Failed',
            middleText: 'Failed to create task',
            barrierDismissible: false,
            onConfirm: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
      },
      onCancel: () {},
      title: 'Add Task',
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
        child: TextField(
          cursorColor: HLColors.primaryColor,
          decoration: new InputDecoration(
              enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: HLColors.primaryColor,
                  width: 2.0,
                ),
              ),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(
                  color: HLColors.primaryColor,
                ),
              ),
              hintText: 'Task Name',
              labelText: 'Enter Task Name',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
              )

              // counterText:
              //     'Leave as empty if you want to create live within app',
              ),
          onChanged: (val) {
            taskName = val;
            // projectName = val;
          },
        ),
      ),
    );
  }
}
