import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/components/customized/gradient_button_component.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/user_modules/controllers/project_controller.dart';

class UpdateProjectPage extends StatefulWidget {
  final Color projectColor;
  final String projectName;
  final String projectId;
  const UpdateProjectPage({
    Key key,
    @required this.projectColor,
    @required this.projectName,
    @required this.projectId,
  }) : super(key: key);
  @override
  _UpdateProjectPageState createState() => _UpdateProjectPageState();
}

class _UpdateProjectPageState extends State<UpdateProjectPage> {
  String projectName = '';
  Color projectColor = Colors.blue;
  final _projectController = Get.find<ProjectController>();
  @override
  void initState() {
    projectName = widget.projectName;
    projectColor = widget.projectColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 30.0),
            _buildHeader(),
            _buildPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        SizedBox(width: 10.0),
        Text(
          'Update Project',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        SizedBox(),
      ],
    );
  }

  Widget _buildPage() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: [
          SizedBox(height: 60.0),
          TextFormField(
            initialValue: projectName,
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
                hintText: 'Project Name',
                labelText: 'Enter Project Name',
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
              projectName = val;
            },
          ),
          SizedBox(height: 50.0),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300.0,
            child: MaterialColorPicker(
              onColorChange: (Color color) {
                // Handle color changes
                projectColor = color;
              },
              selectedColor: projectColor,
            ),
          ),
          SizedBox(height: 30.0),
          GradientButtonComponent(
            alignment: Alignment.center,
            width: 100.0,
            gradientColors: HLColors.secondaryGradient.colors,
            child: Text('Update'),
            onPressed: () async {
              try {
                if (projectName.length > 0) {
                  String hex = projectColor.value.toRadixString(16);
                  Get.defaultDialog(
                    content: CircularProgressIndicator(),
                    title: 'Please wait...',
                    barrierDismissible: false,
                  );
                  await _projectController.updateProject(
                    projectId: widget.projectId,
                    projectName: projectName,
                    colorHex: hex.substring(2, hex.length),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                }
              } catch (e) {
                Get.defaultDialog(
                  // content: CircularProgressIndicator(),
                  title: 'Failed',
                  middleText: 'Failed to update project',
                  barrierDismissible: false,
                  onConfirm: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  },
                );
              }
              // Get.di
            },
          )
        ],
      ),
    );
  }
}
