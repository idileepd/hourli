import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hourli/global_module/components/customized/gradient_button_component.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/user_modules/controllers/project_controller.dart';

class CreateProjectPage extends StatefulWidget {
  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  String projectName = '';
  Color projectColor = Colors.blue;
  final _projectController = Get.find<ProjectController>();

  bool positive = true;
  bool negative = false;
  bool neutral = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
          'Create Project',
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
          _buildTextfield(),
          SizedBox(height: 50.0),
          _buildColorPallet(),
          SizedBox(height: 30.0),
          _buildProjectTypeSelection(),
          SizedBox(height: 30.0),
          _buildCreateProjBtn(),
        ],
      ),
    );
  }

  Padding _buildProjectTypeSelection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                neutral = false;
                positive = false;
                negative = true;
              });
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 50.0,
                  color: Colors.red,
                  child: Icon(
                    LineAwesomeIcons.minus_circle,
                    color: Colors.white,
                  ),
                ),
                Checkbox(value: negative, onChanged: (vak) {})
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                neutral = false;
                positive = true;
                negative = false;
              });
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 50.0,
                  color: Colors.green,
                  child: Icon(
                    LineAwesomeIcons.plus_circle,
                    color: Colors.white,
                  ),
                ),
                Checkbox(value: positive, onChanged: (vak) {})
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                neutral = true;
                positive = false;
                negative = false;
              });
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 50.0,
                  color: Colors.orange,
                  child: Icon(
                    LineAwesomeIcons.equals,
                    color: Colors.white,
                  ),
                ),
                Checkbox(value: neutral, onChanged: (vak) {})
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _buildTextfield() {
    return TextField(
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
    );
  }

  Container _buildColorPallet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.0,
      child: MaterialColorPicker(
        onColorChange: (Color color) {
          // Handle color changes
          projectColor = color;
        },
        selectedColor: Colors.blue,
      ),
    );
  }

  GradientButtonComponent _buildCreateProjBtn() {
    return GradientButtonComponent(
      alignment: Alignment.center,
      width: 100.0,
      gradientColors: HLColors.secondaryGradient.colors,
      child: Text('Create'),
      onPressed: () async {
        try {
          if (projectName.length > 0) {
            String hex = projectColor.value.toRadixString(16);
            Get.defaultDialog(
              content: CircularProgressIndicator(),
              title: 'Please wait',
              barrierDismissible: false,
            );
            await _projectController.createProject(
              projectName: projectName,
              colorHex: hex.substring(2, hex.length),
              positive: positive,
              negative: negative,
              neutral: neutral,
            );

            Navigator.pop(context);
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          }
        } catch (e) {
          Get.defaultDialog(
            // content: CircularProgressIndicator(),
            title: 'Failed',
            middleText: 'Failed to create project',
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
    );
  }
}
