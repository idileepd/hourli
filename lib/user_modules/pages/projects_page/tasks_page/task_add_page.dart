import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/user_modules/controllers/task_controller.dart';

class TaskAddDialog extends StatefulWidget {
  @override
  _TaskAddDialogState createState() => _TaskAddDialogState();
}

class _TaskAddDialogState extends State<TaskAddDialog> {
  TaskController _taskController;
  String taskName = '';
  @override
  void initState() {
    _taskController = Get.find<TaskController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            // initialValue: projectName,
            cursorColor: HLColors.secondaryColor,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: HLColors.secondaryColor,
                    width: 2.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: HLColors.secondaryColor,
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
            },
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
