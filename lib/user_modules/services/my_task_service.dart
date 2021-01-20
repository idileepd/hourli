// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// // import 'package:hourli/models/current_task_model.dart';
// import 'package:hourli/models/user_model.dart';

// class MyTaskService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<bool> createNewTask(
//       {@required String taskName, @required UserDetailsModel userModel}) async {
//     try {
//       //create model.
//       DateTime startedAt = DateTime.now();
//       DateTime endsAt = DateTime(
//           startedAt.year, startedAt.month, startedAt.day, startedAt.hour + 1);

//       CurrentTaskModel currentTaskModel = CurrentTaskModel(
//         // uid: userModel.uid,
//         taskName: taskName,
//         startedAt: startedAt,
//         endsAt: endsAt,
//         // photoUrl: userModel.photoUrl,
//         status: 'ONGOING',
//       );

//       await _firestore
//           .collection("usersCurrentTask")
//           .doc(userModel.uid)
//           .set(currentTaskModel.toMap());

//       return true;
//     } catch (e) {
//       print(e);
//       throw 'Something went wrong !';
//     }
//   }
// }
