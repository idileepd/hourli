import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/models/project_details_model.dart';
// import 'package:hourli/auth_module/controllers/auth_controller.dart';
import 'package:hourli/models/user_deatils_model.dart';

class ProjectController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authController = Get.find<AuthController>();
  final _userController = Get.find<UserController>();
  final _projectService = ProjectService();
  Rx<List<ProjectDetailsModel>> userProjectsRx =
      Rx<List<ProjectDetailsModel>>();

  Stream<List<ProjectDetailsModel>> userProjectsStream(String uid) {
    return _firestore
        .collection("projects")
        .where(
          'adminUid',
          isEqualTo: uid,
        )
        .snapshots()
        .map((QuerySnapshot snap) {
      print("[project Controller] Got projectsss. stream");
      List<ProjectDetailsModel> projects = [];
      snap.docs.forEach((projectDocSnapshot) {
        projects.add(ProjectDetailsModel.fromMap(
            projectDocSnapshot.data(), projectDocSnapshot.id));
      });
      return projects;
      // return UserDetailsModel.fromMap(snap.data());
    });
  }

  Stream<ProjectDetailsModel> projectStream({@required String projectId}) {
    return _firestore
        .collection("projects")
        .doc(projectId)
        .snapshots()
        .map((DocumentSnapshot snap) {
      print("[project Controller] Got project. stream");
      return ProjectDetailsModel.fromMap(snap.data(), snap.id);
    });
  }

  Future<void> createProject({
    @required String projectName,
    @required String colorHex,
    @required positive,
    @required negative,
    @required neutral,
  }) async {
    try {
      int projectType = 0; //neutral
      if (negative == true) projectType = 1;
      if (neutral == true) projectType = 2;
      // print(projectType);
      // print("positive : $positive");
      // print("ne : $negative");
      // print("nu : $neutral");

      await _firestore.collection('projects').add({
        "uids": [_userController.firestoreUserStream.value.uid],
        "adminUid": _userController.firestoreUserStream.value.uid,
        "projectName": projectName,
        "colorHex": colorHex,
        "minutesSpent": 0,
        "isFavourite": false,
        "projectType": projectType,
        "createdOn": Timestamp.now()
      });
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  Future<void> updateProject({
    @required String projectId,
    @required String projectName,
    @required String colorHex,
  }) async {
    try {
      print(projectId);
      await _firestore.collection('projects').doc(projectId).update({
        "projectName": projectName,
        "colorHex": colorHex,
      });
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  Future<void> deleteProject({
    @required String projectId,
  }) async {
    try {
      print(projectId);
      await _firestore.collection('projects').doc(projectId).delete();
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }

  @override
  void onInit() {
    userProjectsRx.bindStream(_projectService
        .userProjectsStream(_authController.firebaseUserStream.value.uid));
    super.onInit();
  }
}

class ProjectService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ProjectDetailsModel>> userProjectsStream(String uid) {
    return _firestore
        .collection("projects")
        .where('adminUid', isEqualTo: uid)
        .orderBy('projectType')
        .orderBy('minutesSpent', descending: true)
        .snapshots()
        .map((QuerySnapshot snap) {
      print("[project Controller] Got projectsss. stream");
      List<ProjectDetailsModel> projects = [];
      snap.docs.forEach((projectDocSnapshot) {
        projects.add(ProjectDetailsModel.fromMap(
            projectDocSnapshot.data(), projectDocSnapshot.id));
      });
      return projects;
      // return UserDetailsModel.fromMap(snap.data());
    });
  }
}
