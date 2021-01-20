import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:number_display/number_display.dart';
import 'package:hourli/global_module/components/customized/gradient_floating_action_btn.dart';
import 'package:hourli/global_module/components/heading_text_component.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/models/project_details_model.dart';
import 'package:hourli/user_modules/controllers/project_controller.dart';
import 'package:hourli/user_modules/pages/projects_page/create_project_page.dart';
import 'package:hourli/user_modules/pages/projects_page/tasks_page/tasks_page.dart';
import 'package:hourli/user_modules/pages/task_coundown_create_page.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectController _projectController;
  @override
  void initState() {
    _projectController =
        Get.put<ProjectController>(ProjectController(), permanent: true);
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
            gradient: HLColors.secondaryGradient,
            onTap: () {
              Get.to(CreateProjectPage());
            },
            icon: Icon(
              LineAwesomeIcons.plus,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            HeadingTextComponent(title: 'Projects', showBack: true),
            // SizedBox(height: 30.0),
            // _buildHeader(),
            _buildProjects(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjects() {
    // return ListTile(
    //   title: Text('project'),
    // );

    return Obx(
      () {
        List<ProjectDetailsModel> snap =
            _projectController.userProjectsRx.value;
        if (snap != null) {
          if (snap.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                Text(
                  "No projects added\nTap '+' button to create project",
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(TasksPage(projectDetailsModel: snap[index]));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              color: Color(
                                  int.parse('0xFF${snap[index].colorHex}')),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(LineAwesomeIcons.stopwatch, size: 30.0),
                            onPressed: () {
                              Get.to(
                                TaskCountDownCreatePage(
                                  taskId: snap[index].projectId,
                                  projectId: snap[index].projectId,
                                  projectName: snap[index].projectName,
                                  taskName: snap[index].projectName,
                                  taskType: snap[index].projectType,
                                ),
                              );
                            },
                          ),
                          title: Text(
                            snap[index].projectName,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            NumberFormat.compact()
                                    .format(snap[index].minutesSpent) +
                                " Min Spent",
                          ),
                          // isThreeLine: true,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snap.length,
              ),
            );
          }
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        );
      },
    );
  }

  // Widget _buildHeader() {
  //   return Row(
  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       IconButton(
  //         icon: Icon(Icons.arrow_back_ios),
  //         onPressed: Get.back,
  //       ),
  //       SizedBox(width: 10.0),
  //       Text(
  //         'Projects',
  //         style: TextStyle(
  //           fontSize: 30.0,
  //         ),
  //       ),
  //       SizedBox(height: 30.0),
  //     ],
  //   );
  // }
}
