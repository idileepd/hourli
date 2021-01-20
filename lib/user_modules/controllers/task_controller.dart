import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/models/project_details_model.dart';
import 'package:hourli/models/task_details_model.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final _authController = Get.find<AuthController>();
  final _userController = Get.find<UserController>();

  final ProjectDetailsModel projectDetailsModel;
  Rx<ProjectDetailsModel> projectDetailsRx = Rx<ProjectDetailsModel>();
  Rx<List<TaskDetailsModel>> inCompleteTasksRx = Rx<List<TaskDetailsModel>>();
  Rx<List<TaskDetailsModel>> completeTasksRx = Rx<List<TaskDetailsModel>>();

  TaskController({@required this.projectDetailsModel});

  @override
  void onInit() {
    projectDetailsRx.bindStream(projectDetailsStream());
    inCompleteTasksRx.bindStream(inCompleteTasksStream());
    completeTasksRx.bindStream(completeTasksStream());
    super.onInit();
  }

  Stream<ProjectDetailsModel> projectDetailsStream() {
    return _firestore
        .collection('projects')
        .doc(projectDetailsModel.projectId)
        .snapshots()
        .map((snap) {
      return ProjectDetailsModel.fromMap(snap.data(), snap.id);
    });
  }

  Stream<List<TaskDetailsModel>> inCompleteTasksStream() {
    return _firestore
        .collection('projects')
        .doc(projectDetailsModel.projectId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((snap) {
      // print("Incomplete tasks stream");
      // print(snap.docs[0]?.data());
      // print("incompleted !!!!");
      // print(snap.docs.length);
      List<TaskDetailsModel> tasks = [];
      snap.docs.forEach((taskDocSnap) {
        if (taskDocSnap.data() != null)
          tasks.add(
              TaskDetailsModel.fromMap(taskDocSnap.data(), taskDocSnap.id));
      });
      return tasks;
    });
  }

  Stream<List<TaskDetailsModel>> completeTasksStream() {
    return _firestore
        .collection('projects')
        .doc(projectDetailsModel.projectId)
        .collection('tasks')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((snap) {
      print("completed !!!!");
      print(snap.docs.length);
      List<TaskDetailsModel> tasks = [];
      snap.docs.forEach((taskDocSnap) {
        if (taskDocSnap.data() != null)
          tasks.add(
              TaskDetailsModel.fromMap(taskDocSnap.data(), taskDocSnap.id));
      });
      return tasks;
    });
  }

  Future<void> deleteTask({
    @required String projectId,
    @required String taskId,
  }) async {
    try {
      // print(projectId);
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  Future<void> createTask({
    @required String projectId,
    @required String taskName,
  }) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .add({
        "uids": [_userController.firestoreUserStream.value.uid],
        "adminUid": _userController.firestoreUserStream.value.uid,
        "taskName": taskName,
        "minutesSpent": 0,
        "isCompleted": false,
        "createdOn": Timestamp.now(),
        "lastUpdateOn": Timestamp.now()
      });
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  Future<void> updateTaskName({
    @required String projectId,
    @required String taskName,
    @required String taskId,
  }) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .update({"taskName": taskName, "lastUpdateOn": Timestamp.now()});
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  Future<void> updateTaskStatus({
    @required String projectId,
    @required bool taskStatus,
    @required String taskId,
  }) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .update({"isCompleted": taskStatus, "lastUpdateOn": Timestamp.now()});
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }
}
